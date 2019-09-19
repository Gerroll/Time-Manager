defmodule ServerWeb.UserController do
  use ServerWeb, :controller

  alias Server.GUsers
  alias Server.GUsers.User
  alias Server.GWorkingtimes
  alias Server.GWorkingtimes.Workingtime
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
    Enum.each(wTimes, fn w -> GWorkingtimes.delete_workingtime(w) end)

    links = GLinkTeams.getLinkTeamByUserId(userId)
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

    user = GUsers.get_user!(userId)
    with {:ok, %User{}} <- GUsers.delete_user(user) do
      send_resp(conn, :ok, "ok")
    end
  end

  def getUserListInTeam(conn, %{"team_id" => team_id}) do
    linkTeam = GLinkTeams.getLinkTeamByTeamId(team_id)
    list_users_id = Enum.map(linkTeam, fn(lt) -> lt.user_id end)
    users = GUsers.getUserWhereListUserId(list_users_id)
    render(conn, "index.json", users: users)
  end

  def getUserListNotInTeam(conn, %{"team_id" => team_id}) do
    linkTeam = GLinkTeams.getLinkTeamByTeamId(team_id)
    list_users_id = Enum.map(linkTeam, fn(lt) -> lt.user_id end)
    users = GUsers.getUserWhereListNotUserId(list_users_id)
    render(conn, "index.json", users: users)
  end

  ### AUTH PART ###
  def sign_in(conn, %{"email" => email, "password" => password}) do
    users = GUsers.getUserWhereEmail(email)
    if users do
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
end
