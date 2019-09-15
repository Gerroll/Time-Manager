defmodule ServerWeb.WorkingtimesController do
  use ServerWeb, :controller

  alias Server.GWorkingtimes
  alias Server.GWorkingtimes.Workingtimes

  action_fallback ServerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = GWorkingtimes.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtimes" => workingtimes_params}) do
    with {:ok, %Workingtimes{} = workingtimes} <- GWorkingtimes.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes))
      |> render("show.json", workingtimes: workingtimes)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtimes = GWorkingtimes.get_workingtimes!(id)
    render(conn, "show.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = GWorkingtimes.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- GWorkingtimes.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, "show.json", workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = GWorkingtimes.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- GWorkingtimes.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end
end
