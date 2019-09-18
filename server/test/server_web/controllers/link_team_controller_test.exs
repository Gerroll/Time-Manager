defmodule ServerWeb.LinkTeamControllerTest do
  use ServerWeb.ConnCase

  alias Server.GLinkTeams
  alias Server.GLinkTeams.LinkTeam

  @create_attrs %{
    manager: true
  }
  @update_attrs %{
    manager: false
  }
  @invalid_attrs %{manager: nil}

  def fixture(:link_team) do
    {:ok, link_team} = GLinkTeams.create_link_team(@create_attrs)
    link_team
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all linkteams", %{conn: conn} do
      conn = get(conn, Routes.link_team_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create link_team" do
    test "renders link_team when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_team_path(conn, :create), link_team: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.link_team_path(conn, :show, id))

      assert %{
               "id" => id,
               "manager" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_team_path(conn, :create), link_team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update link_team" do
    setup [:create_link_team]

    test "renders link_team when data is valid", %{conn: conn, link_team: %LinkTeam{id: id} = link_team} do
      conn = put(conn, Routes.link_team_path(conn, :update, link_team), link_team: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.link_team_path(conn, :show, id))

      assert %{
               "id" => id,
               "manager" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, link_team: link_team} do
      conn = put(conn, Routes.link_team_path(conn, :update, link_team), link_team: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete link_team" do
    setup [:create_link_team]

    test "deletes chosen link_team", %{conn: conn, link_team: link_team} do
      conn = delete(conn, Routes.link_team_path(conn, :delete, link_team))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.link_team_path(conn, :show, link_team))
      end
    end
  end

  defp create_link_team(_) do
    link_team = fixture(:link_team)
    {:ok, link_team: link_team}
  end
end
