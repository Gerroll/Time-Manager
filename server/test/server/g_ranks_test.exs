defmodule Server.GRanksTest do
  use Server.DataCase

  alias Server.GRanks

  describe "ranks" do
    alias Server.GRanks.Rank

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def rank_fixture(attrs \\ %{}) do
      {:ok, rank} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GRanks.create_rank()

      rank
    end

    test "list_ranks/0 returns all ranks" do
      rank = rank_fixture()
      assert GRanks.list_ranks() == [rank]
    end

    test "get_rank!/1 returns the rank with given id" do
      rank = rank_fixture()
      assert GRanks.get_rank!(rank.id) == rank
    end

    test "create_rank/1 with valid data creates a rank" do
      assert {:ok, %Rank{} = rank} = GRanks.create_rank(@valid_attrs)
      assert rank.name == "some name"
    end

    test "create_rank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GRanks.create_rank(@invalid_attrs)
    end

    test "update_rank/2 with valid data updates the rank" do
      rank = rank_fixture()
      assert {:ok, %Rank{} = rank} = GRanks.update_rank(rank, @update_attrs)
      assert rank.name == "some updated name"
    end

    test "update_rank/2 with invalid data returns error changeset" do
      rank = rank_fixture()
      assert {:error, %Ecto.Changeset{}} = GRanks.update_rank(rank, @invalid_attrs)
      assert rank == GRanks.get_rank!(rank.id)
    end

    test "delete_rank/1 deletes the rank" do
      rank = rank_fixture()
      assert {:ok, %Rank{}} = GRanks.delete_rank(rank)
      assert_raise Ecto.NoResultsError, fn -> GRanks.get_rank!(rank.id) end
    end

    test "change_rank/1 returns a rank changeset" do
      rank = rank_fixture()
      assert %Ecto.Changeset{} = GRanks.change_rank(rank)
    end
  end
end
