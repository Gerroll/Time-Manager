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

  def clockIn(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    wTimes = GWorkingtimes.getWorkingtimesByUserId(user_id)
    alreadyClockIn = Enum.any?(wTimes, fn(w) -> w.start == w.end end)
    if alreadyClockIn do
      conn
      |> put_status(:bad_request)
      |> json("KO : Already clock in, need to clock out")
    else
      dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 7200, :second)
      workingtime_params = %{user_id: user_id, start: dt, end: dt}
      with {:ok, %Workingtime{} = workingtime} <- GWorkingtimes.create_workingtime(workingtime_params) do
        conn
        |> put_status(:created)
        |> render("show.json", workingtime: workingtime)
      end
    end
  end

  def clockOut(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    wTimes = GWorkingtimes.getWorkingtimesByUserId(user_id)
    needToClockOut = Enum.any?(wTimes, fn(w) -> w.start == w.end end)

    if needToClockOut do
      w_clock = Enum.find(wTimes, fn w -> w.start == w.end end)
      workingtime = GWorkingtimes.get_workingtime!(w_clock.id)
      dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 7200, :second)
      with {:ok, %Workingtime{} = workingtime} <- GWorkingtimes.update_workingtime(workingtime, %{end: dt}) do
        render(conn, "show.json", workingtime: workingtime)
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : Need to clock in first")
    end
  end

  def getWorkingTimeForUser(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    wTimes = GWorkingtimes.getWorkingtimesByUserId(user_id)
    render(conn, "index.json", workingtimes: wTimes)
  end

  def getDashboardOfUser(conn, %{"user_id" => user_id}) do
    wTimes = GWorkingtimes.getWorkingtimesByUserId(user_id)
    averagePerDayOf7pastDay = Enum.sum(Enum.map(wTimes, fn wt ->
      if (NaiveDateTime.compare(wt.start, NaiveDateTime.add(NaiveDateTime.utc_now(), -604800, :second)) == :gt and wt.end !== wt.start) do
        NaiveDateTime.diff(wt.end, wt.start)
      else
        0
      end
    end)) / 5

    averagePerWeekOf28pastDay = Enum.sum(Enum.map(wTimes, fn wt ->
      if (NaiveDateTime.compare(wt.start, NaiveDateTime.add(NaiveDateTime.utc_now(), -2419200, :second)) == :gt and wt.end !== wt.start) do
        NaiveDateTime.diff(wt.end, wt.start)
      else
        0
      end
    end)) / 4

    workTimesPast7Days = Enum.map(wTimes, fn wt ->
      if (NaiveDateTime.compare(wt.start, NaiveDateTime.add(NaiveDateTime.utc_now(), -604800, :second)) == :gt and wt.end !== wt.start) do
        %{start: wt.start, end: wt.end}
      end
    end)
  
    workTimesPast28Days = Enum.map(wTimes, fn wt ->
      if (NaiveDateTime.compare(wt.start, NaiveDateTime.add(NaiveDateTime.utc_now(), -2419200, :second)) == :gt and wt.end !== wt.start) do
        %{start: wt.start, end: wt.end}
      end
    end)

    conn
    |> put_status(:ok)
    |> json(%{
      averagePerDayOf7pastDay: averagePerDayOf7pastDay,
      averagePerWeekOf28pastDay: averagePerWeekOf28pastDay,
      workTimesPast7Days: workTimesPast7Days,
      workTimesPast28Days: workTimesPast28Days,
    })
  end

  def getDashboard(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    getDashboardOfUser(conn, %{"user_id" => user_id})
  end
end
