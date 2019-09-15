defmodule Server.GWorkingtimesTest do
  use Server.DataCase

  alias Server.GWorkingtimes

  describe "workingtimes" do
    alias Server.GWorkingtimes.Workingtimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtimes_fixture(attrs \\ %{}) do
      {:ok, workingtimes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GWorkingtimes.create_workingtimes()

      workingtimes
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert GWorkingtimes.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert GWorkingtimes.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      assert {:ok, %Workingtimes{} = workingtimes} = GWorkingtimes.create_workingtimes(@valid_attrs)
      assert workingtimes.end == ~N[2010-04-17 14:00:00]
      assert workingtimes.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GWorkingtimes.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{} = workingtimes} = GWorkingtimes.update_workingtimes(workingtimes, @update_attrs)
      assert workingtimes.end == ~N[2011-05-18 15:01:01]
      assert workingtimes.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = GWorkingtimes.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == GWorkingtimes.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = GWorkingtimes.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> GWorkingtimes.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = GWorkingtimes.change_workingtimes(workingtimes)
    end
  end
end
