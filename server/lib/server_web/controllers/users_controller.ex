defmodule ServerWeb.UsersController do
  use ServerWeb, :controller

  alias Server.GUsers
  alias Server.GUsers.Users

  action_fallback ServerWeb.FallbackController

  def index(conn, %{"email" => email, "username" => username}) do
    users = GUsers.list_users()
    # m = %{}
    # Enum.each([1, 2, 3], fn x -> m = Map.put(m, x, x) end)
    # test = Map.put(%{a => 1, 2 => :b}, :c, 3)

    # IO.inspect Enum.at(users, 1)
    u = Enum.at(users, 1)
    IO.inspect u["email"]
    e = Map.get(u, "email")
    IO.inspect e

    # a = Map.get(users: users, :data)
    # b = Map.get(%{:a => [%{"users" => "azd"}], 2 => :b}, :a)
    # render(conn, "index.json", users: users)

    json(conn, %{"a" => "b"})

    # json(conn, u)
    # json(conn, %{"a" => email, "b" => username})
    # render(conn, "index.json", users: u)
  end

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json("KO")
  end

  def create(conn, %{"users" => users_params}) do
    with {:ok, %Users{} = users} <- GUsers.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = GUsers.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = GUsers.get_users!(id)

    with {:ok, %Users{} = users} <- GUsers.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = GUsers.get_users!(id)

    with {:ok, %Users{}} <- GUsers.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
