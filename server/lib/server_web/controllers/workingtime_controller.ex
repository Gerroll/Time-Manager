defmodule ServerWeb.WorkingtimeController do
  use ServerWeb, :controller

  alias Server.GWorkingtimes
  alias Server.GWorkingtimes.Workingtime

  action_fallback ServerWeb.FallbackController

  # def index(conn, _params) do
  #   workingtimes = GWorkingtimes.list_workingtimes()
  #   render(conn, "index.json", workingtimes: workingtimes)
  # end

  # def create(conn, %{"workingtime" => workingtime_params}) do
  #   with {:ok, %Workingtime{} = workingtime} <- GWorkingtimes.create_workingtime(workingtime_params) do
  #     conn
  #     |> put_status(:created)
  #     |> render("show.json", workingtime: workingtime)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   workingtime = GWorkingtimes.get_workingtime!(id)
  #   render(conn, "show.json", workingtime: workingtime)
  # end

  # def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
  #   workingtime = GWorkingtimes.get_workingtime!(id)

  #   with {:ok, %Workingtime{} = workingtime} <- GWorkingtimes.update_workingtime(workingtime, workingtime_params) do
  #     render(conn, "show.json", workingtime: workingtime)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   workingtime = GWorkingtimes.get_workingtime!(id)

  #   with {:ok, %Workingtime{}} <- GWorkingtimes.delete_workingtime(workingtime) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  def clockIn(conn, %{"userId" => userId}) do
    # IO.inspect DateTime.now("Europe/France")
    # DateTime.now("Etc/UTC")
    IO.inspect NaiveDateTime.utc_now

    conn
    |> put_status(:bad_request)
    |> json(NaiveDateTime.utc_now)


    # with {:ok, %Workingtime{} = workingtime} <- GWorkingtimes.create_workingtime(workingtime_params) do
    #   conn
    #   |> put_status(:created)
    #   |> render("show.json", workingtime: workingtime)
    # end
  end
end
