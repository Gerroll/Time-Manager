defmodule Server.GLinkTeamsTest do
  use Server.DataCase

  alias Server.GLinkTeams

  describe "linkteams" do
    alias Server.GLinkTeams.LinkTeam

    @valid_attrs %{manager: true}
    @update_attrs %{manager: false}
    @invalid_attrs %{manager: nil}

    def link_team_fixture(attrs \\ %{}) do
      {:ok, link_team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GLinkTeams.create_link_team()

      link_team
    end

    test "list_linkteams/0 returns all linkteams" do
      link_team = link_team_fixture()
      assert GLinkTeams.list_linkteams() == [link_team]
    end

    test "get_link_team!/1 returns the link_team with given id" do
      link_team = link_team_fixture()
      assert GLinkTeams.get_link_team!(link_team.id) == link_team
    end

    test "create_link_team/1 with valid data creates a link_team" do
      assert {:ok, %LinkTeam{} = link_team} = GLinkTeams.create_link_team(@valid_attrs)
      assert link_team.manager == true
    end

    test "create_link_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GLinkTeams.create_link_team(@invalid_attrs)
    end

    test "update_link_team/2 with valid data updates the link_team" do
      link_team = link_team_fixture()
      assert {:ok, %LinkTeam{} = link_team} = GLinkTeams.update_link_team(link_team, @update_attrs)
      assert link_team.manager == false
    end

    test "update_link_team/2 with invalid data returns error changeset" do
      link_team = link_team_fixture()
      assert {:error, %Ecto.Changeset{}} = GLinkTeams.update_link_team(link_team, @invalid_attrs)
      assert link_team == GLinkTeams.get_link_team!(link_team.id)
    end

    test "delete_link_team/1 deletes the link_team" do
      link_team = link_team_fixture()
      assert {:ok, %LinkTeam{}} = GLinkTeams.delete_link_team(link_team)
      assert_raise Ecto.NoResultsError, fn -> GLinkTeams.get_link_team!(link_team.id) end
    end

    test "change_link_team/1 returns a link_team changeset" do
      link_team = link_team_fixture()
      assert %Ecto.Changeset{} = GLinkTeams.change_link_team(link_team)
    end
  end
end
