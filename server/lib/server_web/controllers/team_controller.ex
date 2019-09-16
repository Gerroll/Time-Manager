defmodule ServerWeb.TeamController do
  use ServerWeb, :controller

  alias Server.GTeams
  alias Server.GTeams.Team

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    teams = GTeams.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    teams = GTeams.list_teams()
    exist = Enum.any?(teams, fn(t) -> t.name == team_params["name"] end)
    if !exist do
      with {:ok, %Team{} = team} <- GTeams.create_team(team_params) do
        conn
        |> put_status(:created)
        |> render("show.json", team: team)
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO")
    end
  end

  def show(conn, %{"id" => id}) do
    team = GTeams.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = GTeams.get_team!(id)

    with {:ok, %Team{} = team} <- GTeams.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = GTeams.get_team!(id)

    with {:ok, %Team{}} <- GTeams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end
end
