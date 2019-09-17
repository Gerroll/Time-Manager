defmodule Server.GTeamsTest do
  use Server.DataCase

  alias Server.GTeams

  describe "teams" do
    alias Server.GTeams.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GTeams.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert GTeams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert GTeams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = GTeams.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GTeams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = GTeams.update_team(team, @update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = GTeams.update_team(team, @invalid_attrs)
      assert team == GTeams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = GTeams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> GTeams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = GTeams.change_team(team)
    end
  end

  describe "teams" do
    alias Server.GTeams.Team

    @valid_attrs %{manager_id: 42, name: "some name"}
    @update_attrs %{manager_id: 43, name: "some updated name"}
    @invalid_attrs %{manager_id: nil, name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GTeams.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert GTeams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert GTeams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = GTeams.create_team(@valid_attrs)
      assert team.manager_id == 42
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GTeams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = GTeams.update_team(team, @update_attrs)
      assert team.manager_id == 43
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = GTeams.update_team(team, @invalid_attrs)
      assert team == GTeams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = GTeams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> GTeams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = GTeams.change_team(team)
    end
  end
end
