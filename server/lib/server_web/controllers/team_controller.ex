defmodule ServerWeb.TeamController do
  use ServerWeb, :controller

  alias Server.GTeams
  alias Server.GTeams.Team
  alias Server.GLinkTeams

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    teams = GTeams.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    teams = GTeams.list_teams()
    exist = Enum.any?(teams, fn(t) -> t.name === team_params["name"] end)
    if !exist do
      with {:ok, %Team{} = team} <- GTeams.create_team(team_params) do
        GLinkTeams.create_link_team(%{"team_id" => team.id, "user_id" => user_id, "manager" => true})
        conn
        |> put_status(:created)
        |> render("show.json", team: team)
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : team name already taken")
    end
  end

  def update(conn, %{"team_id" => team_id, "team" => team_params}) do
    team = GTeams.get_team!(team_id)

    with {:ok, %Team{} = team} <- GTeams.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"team_id" => team_id}) do
    team = GTeams.get_team!(team_id)
    link = GLinkTeams.getLinkTeamByTeamId(team_id)
    Enum.each(link, fn lt -> GLinkTeams.delete_link_team(lt) end)
    with {:ok, %Team{}} <- GTeams.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def getListTeamForManager(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    link_team = GLinkTeams.getLinkTeamByUserIdAndIsManager(user_id)
    teams = Enum.map(link_team, fn(lt) ->
      GTeams.get_team!(lt.id)
    end)
    render(conn, "index.json", teams: teams)
  end
end
