defmodule ServerWeb.RankControllerTest do
  use ServerWeb.ConnCase

  alias Server.GRanks
  alias Server.GRanks.Rank

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:rank) do
    {:ok, rank} = GRanks.create_rank(@create_attrs)
    rank
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all ranks", %{conn: conn} do
      conn = get(conn, Routes.rank_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rank" do
    test "renders rank when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rank_path(conn, :create), rank: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rank_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rank_path(conn, :create), rank: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rank" do
    setup [:create_rank]

    test "renders rank when data is valid", %{conn: conn, rank: %Rank{id: id} = rank} do
      conn = put(conn, Routes.rank_path(conn, :update, rank), rank: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.rank_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, rank: rank} do
      conn = put(conn, Routes.rank_path(conn, :update, rank), rank: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rank" do
    setup [:create_rank]

    test "deletes chosen rank", %{conn: conn, rank: rank} do
      conn = delete(conn, Routes.rank_path(conn, :delete, rank))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.rank_path(conn, :show, rank))
      end
    end
  end

  defp create_rank(_) do
    rank = fixture(:rank)
    {:ok, rank: rank}
  end
end
