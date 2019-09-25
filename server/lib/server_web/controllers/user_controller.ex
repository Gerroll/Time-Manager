defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.GUsers
  alias Server.GUsers.User
  alias Server.GWorkingtimes
  alias Server.GLinkTeams
  alias Server.GTeams

  action_fallback ServerWeb.FallbackController

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

  def getUserList(conn, %{}) do
    users = GUsers.list_users()
    render(conn, "index.json", users: users)
  end

  def getInfoUser(conn, %{}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    user = GUsers.get_user!(user_id)
    render(conn, "show.json", user: user)
  end

  def updateInfoUser(conn, %{"user" => user_params}) do
    user_id = Kernel.elem(Server.Token.verify_and_validate(Kernel.elem(Enum.find(conn.req_headers, fn x -> Kernel.elem(x, 0) == "x-xsrf-token" end), 1)), 1)["user_id"]
    user = GUsers.get_user!(user_id)

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

  def deleteUser(conn, %{"user_id" => user_id}) do
    wTimes = GWorkingtimes.getWorkingtimesByUserId(user_id)
    Enum.each(wTimes, fn w -> GWorkingtimes.delete_workingtime(w) end)

    links = GLinkTeams.getLinkTeamByUserId(user_id)
    Enum.each(links, fn lt ->
      if lt.manager do
        link = GLinkTeams.getLinkTeamByTeamId(lt.team_id)
        Enum.each(link, fn lt -> GLinkTeams.delete_link_team(lt) end)
        teamToDel = GTeams.get_team!(lt.team_id)
        GTeams.delete_team(teamToDel)
      else
        GLinkTeams.delete_link_team(lt)
      end
    end)

    user = GUsers.get_user!(user_id)
    with {:ok, %User{}} <- GUsers.delete_user(user) do
      send_resp(conn, :ok, "ok")
    end
  end

  def getUserListInTeam(conn, %{"team_id" => team_id}) do
    linkTeam = GLinkTeams.getLinkTeamByTeamId(team_id)
    list_users_id = Enum.map(linkTeam, fn(lt) ->
      if lt.manager == false do
        lt.user_id
      end
    end)
    users = GUsers.getUserWhereListUserId(list_users_id)
    render(conn, "index.json", users: users)
  end

  def getUserListNotInTeam(conn, %{"team_id" => team_id}) do
    linkTeam = GLinkTeams.getLinkTeamByTeamId(team_id)
    list_users_id = Enum.map(linkTeam, fn(lt) -> lt.user_id end)
    users = GUsers.getUserWhereListNotUserId(list_users_id)
    render(conn, "index.json", users: users)
  end

  def updateRankUser(conn, %{"user_id" => user_id, "rank" => rank}) do
    user = GUsers.get_user!(user_id)
    if rank != "employee" and rank != "manager" and rank != "general" do
      conn
      |> put_status(:bad_request)
      |> json("KO: bad rank update")
    else
      GUsers.update_user(user, %{"rank" => rank})
      conn
      |> put_status(:ok)
      |> json("ok")
    end
  end

  def getListRank(conn, %{}) do
    conn
    |> put_status(:ok)
    |> json(%{"list" => ["employee", "manager", "general"]})
  end

  ### AUTH PART ###
  def sign_in(conn, %{"email" => email, "password" => password}) do
    users = GUsers.getUserWhereEmail(email)
    if users != [] and email != nil and password != nil do
      u = Enum.at(users, 0)
      if Bcrypt.verify_pass(password, u.password) do
        token = Server.Token.generate_and_sign!(%{"user_id" => u.id, "rank" => u.rank})
        conn
        |> put_status(:ok)
        |> json(%{"token" => token, "user_id" => u.id, "rank" => u.rank})
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

  def verifyToken(conn, %{}) do
    conn
    |> put_status(:ok)
    |> json("ok")
  end
end
