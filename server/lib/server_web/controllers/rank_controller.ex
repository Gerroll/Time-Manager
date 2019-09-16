defmodule ServerWeb.RankController do
  use ServerWeb, :controller

  alias Server.GRanks
  alias Server.GRanks.Rank

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    ranks = GRanks.list_ranks()
    render(conn, "index.json", ranks: ranks)
  end

  def create(conn, %{"rank" => rank_params}) do
    with {:ok, %Rank{} = rank} <- GRanks.create_rank(rank_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.rank_path(conn, :show, rank))
      |> render("show.json", rank: rank)
    end
  end

  def show(conn, %{"id" => id}) do
    rank = GRanks.get_rank!(id)
    render(conn, "show.json", rank: rank)
  end

  def update(conn, %{"id" => id, "rank" => rank_params}) do
    rank = GRanks.get_rank!(id)

    with {:ok, %Rank{} = rank} <- GRanks.update_rank(rank, rank_params) do
      render(conn, "show.json", rank: rank)
    end
  end

  def delete(conn, %{"id" => id}) do
    rank = GRanks.get_rank!(id)

    with {:ok, %Rank{}} <- GRanks.delete_rank(rank) do
      send_resp(conn, :no_content, "")
    end
  end
end
