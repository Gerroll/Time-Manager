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
      user_params = Map.replace!(user_params, "password", Bcrypt.hash_pwd_salt(user_params["password"]))
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
  # def getUserList(conn, %{"token" => token}) do
  #   IO.inspect Server.Token.verify_and_validate(token)

  #   users = GUsers.list_users()
  #   render(conn, "index.json", users: users)
  # end

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


  ### AUTH PART ###
  def sign_in(conn, %{"email" => email, "password" => password}) do
    users = GUsers.getUserWhereEmail(email)
    if users do
      u = Enum.at(users, 0)
      if Bcrypt.verify_pass(password, u.password) do
        token = Server.Token.generate_and_sign()

        dt = NaiveDateTime.add(NaiveDateTime.utc_now(), 2592000, :second)
        sendInfo = %{"token" => Kernel.elem(token,1), "user_id" => u.id, "rank" => u.rank, "expire_token" => dt}

        upUser = %{"token" => Kernel.elem(token,1), "expire_token" => dt}
        with {:ok, %User{} = user} <- GUsers.update_user(u, upUser) do
          conn
          |> put_status(:ok)
          |> json(sendInfo)
        end
      else
        conn
        |> put_status(:bad_request)
        |> json("KO: bad password for this email")
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO: no account for this email")
    end
  end

  def sign_out(conn, %{"userId" => userId}) do
    user = GUsers.get_user!(userId)
    if user do
      upUser = %{"token" => nil, "expire_token" => nil}
      with {:ok, %User{} = user} <- GUsers.update_user(user, upUser) do
        conn
        |> put_status(:ok)
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(:bad_request)
      |> json("KO : Bad userId")
    end
  end

end
