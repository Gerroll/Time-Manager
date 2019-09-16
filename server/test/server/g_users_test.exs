defmodule Server.GUsersTest do
  use Server.DataCase

  alias Server.GUsers

  describe "users" do
    alias Server.GUsers.User

    @valid_attrs %{email: "some email", password: "some password", username: "some username"}
    @update_attrs %{email: "some updated email", password: "some updated password", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GUsers.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert GUsers.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert GUsers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = GUsers.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GUsers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = GUsers.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = GUsers.update_user(user, @invalid_attrs)
      assert user == GUsers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = GUsers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> GUsers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = GUsers.change_user(user)
    end
  end

  describe "users" do
    alias Server.GUsers.User

    @valid_attrs %{email: "some email", password: "some password", rank: "some rank", username: "some username"}
    @update_attrs %{email: "some updated email", password: "some updated password", rank: "some updated rank", username: "some updated username"}
    @invalid_attrs %{email: nil, password: nil, rank: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GUsers.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert GUsers.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert GUsers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = GUsers.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.rank == "some rank"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GUsers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = GUsers.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.rank == "some updated rank"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = GUsers.update_user(user, @invalid_attrs)
      assert user == GUsers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = GUsers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> GUsers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = GUsers.change_user(user)
    end
  end
end
