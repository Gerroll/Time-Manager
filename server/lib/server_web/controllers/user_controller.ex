defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.GUsers
  alias Server.GUsers.User
  alias Server.GWorkingtimes
  alias Server.GWorkingtimes.Workingtime

  action_fallback ServerWeb.FallbackController

  # def index(conn, _params) do
  #   users = GUsers.list_users()
  #   render(conn, "index.json", users: users)
  # end

  def createUser(conn, %{"user" => user_params}) do
    users = GUsers.list_users()
    exist = Enum.any?(users, fn(u) -> u.email == user_params["email"] end)

    if !exist do
      with {:ok, %User{} = user} <- GUsers.create_user(user_params) do
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : email already link to an other account")
    end
  end

  # def show(conn, %{"id" => id}) do
  #   user = GUsers.get_user!(id)
  #   render(conn, "show.json", user: user)
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = GUsers.get_user!(id)

  #   with {:ok, %User{} = user} <- GUsers.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = GUsers.get_user!(id)

  #   with {:ok, %User{}} <- GUsers.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end


  def getUserList(conn, %{}) do
    users = GUsers.list_users()
    render(conn, "index.json", users: users)
  end

  def getInfoUser(conn, %{"userId" => userId}) do
    user = GUsers.get_user!(userId)
    render(conn, "show.json", user: user)
  end

  def updateInfoUser(conn, %{"userId" => userId, "user" => user_params}) do
    user = GUsers.get_user!(userId)

    users = GUsers.list_users()
    exist = Enum.any?(users, fn(u) -> u.email == user_params["email"] end)
    if exist do
      conn
      |> put_status(:bad_request)
      |> json("KO : email already link to an other account")
    else
      u = if user_params["username"], do: Map.put(%{}, "username", user_params["username"]), else: %{}
      u = if user_params["password"], do: Map.put(u, "password", user_params["password"]), else: u
      u = if user_params["email"], do: Map.put(u, "email", user_params["email"]), else: u

      with {:ok, %User{} = user} <- GUsers.update_user(user, u) do
        render(conn, "show.json", user: user)
      end
    end
  end

  def deleteUser(conn, %{"userId" => userId}) do
    wTimes = GWorkingtimes.getWorkingtimesByUserId(userId)

    Enum.each(wTimes, fn w -> 
      with {:ok, %Workingtime{}} <- GWorkingtimes.delete_workingtime(w) do
        # send_resp(conn, :no_content, "")
      end
    end)

    # workingtime = GWorkingtimes.get_workingtime!(id)
    # with {:ok, %Workingtime{}} <- GWorkingtimes.delete_workingtime(workingtime) do
    #   send_resp(conn, :no_content, "")
    # end


    user = GUsers.get_user!(userId)
    with {:ok, %User{}} <- GUsers.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

end
