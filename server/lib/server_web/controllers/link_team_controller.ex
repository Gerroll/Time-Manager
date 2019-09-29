defmodule ServerWeb.LinkTeamController do
  use ServerWeb, :controller

  alias Server.GLinkTeams
  alias Server.GLinkTeams.LinkTeam

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    linkteams = GLinkTeams.list_linkteams()
    render(conn, "index.json", linkteams: linkteams)
  end

  def create(conn, %{"link_team" => link_team_params}) do
    with {:ok, %LinkTeam{} = link_team} <- GLinkTeams.create_link_team(link_team_params) do
      conn
      |> put_status(:created)
      |> render("show.json", link_team: link_team)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   link_team = GLinkTeams.get_link_team!(id)
  #   render(conn, "show.json", link_team: link_team)
  # end

  # def update(conn, %{"id" => id, "link_team" => link_team_params}) do
  #   link_team = GLinkTeams.get_link_team!(id)

  #   with {:ok, %LinkTeam{} = link_team} <- GLinkTeams.update_link_team(link_team, link_team_params) do
  #     render(conn, "show.json", link_team: link_team)
  #   end
  # end

  def addUserToTeam(conn, %{"user_id" => user_id, "team_id" => team_id}) do
    link_team_params = %{team_id: team_id, user_id: user_id, manager: false}
    with {:ok, %LinkTeam{} = link_team} <- GLinkTeams.create_link_team(link_team_params) do
      conn
      |> put_status(:created)
      |> render("show.json", link_team: link_team)
    end
  end

  def removeUserFromTeam(conn, %{"user_id" => user_id, "team_id" => team_id}) do
    link_team = GLinkTeams.getLinkTeamByUserIdAndTeamId(user_id, team_id)
    if link_team do
      GLinkTeams.delete_link_team(Enum.at(link_team, 0))
      conn
      |> put_status(:ok)
      |> json("ok")
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : not found")
    end
  end
end
