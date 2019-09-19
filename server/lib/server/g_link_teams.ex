defmodule Server.GLinkTeams do
  @moduledoc """
  The GLinkTeams context.
  """

  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.GLinkTeams.LinkTeam

  @doc """
  Returns the list of linkteams.

  ## Examples

      iex> list_linkteams()
      [%LinkTeam{}, ...]

  """
  def list_linkteams do
    Repo.all(LinkTeam)
  end

  @doc """
  Gets a single link_team.

  Raises `Ecto.NoResultsError` if the Link team does not exist.

  ## Examples

      iex> get_link_team!(123)
      %LinkTeam{}

      iex> get_link_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link_team!(id), do: Repo.get!(LinkTeam, id)

  @doc """
  Creates a link_team.

  ## Examples

      iex> create_link_team(%{field: value})
      {:ok, %LinkTeam{}}

      iex> create_link_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link_team(attrs \\ %{}) do
    %LinkTeam{}
    |> LinkTeam.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link_team.

  ## Examples

      iex> update_link_team(link_team, %{field: new_value})
      {:ok, %LinkTeam{}}

      iex> update_link_team(link_team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link_team(%LinkTeam{} = link_team, attrs) do
    link_team
    |> LinkTeam.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LinkTeam.

  ## Examples

      iex> delete_link_team(link_team)
      {:ok, %LinkTeam{}}

      iex> delete_link_team(link_team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link_team(%LinkTeam{} = link_team) do
    Repo.delete(link_team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link_team changes.

  ## Examples

      iex> change_link_team(link_team)
      %Ecto.Changeset{source: %LinkTeam{}}

  """
  def change_link_team(%LinkTeam{} = link_team) do
    LinkTeam.changeset(link_team, %{})
  end


  # def getUserInTeam(team_id) do
  #   query = (from lt in Workingtime,
  #     where: lt.team_id == ^(team_id),
  #     select: %Workingtime{id: lt.id, team_id: lt.team_id, user_id: lt.user_id})
  #   Repo.all(query)
  # end

  def getLinkTeamByTeamId(team_id) do
    query = (from lt in LinkTeam,
      where: lt.team_id == ^(team_id),
      select: %LinkTeam{id: lt.id, team_id: lt.team_id, user_id: lt.user_id})
    Repo.all(query)
  end

  def getLinkTeamByUserId(user_id) do
    query = (from lt in LinkTeam,
      where: lt.user_id == ^(user_id),
      select: %LinkTeam{id: lt.id, team_id: lt.team_id, user_id: lt.user_id})
    Repo.all(query)
  end

  def getLinkTeamByUserIdAndTeamId(user_id, team_id) do
    query = (from lt in LinkTeam,
      where: lt.user_id == ^(user_id) and lt.team_id == ^(team_id),
      select: %LinkTeam{id: lt.id, team_id: lt.team_id, user_id: lt.user_id})
    Repo.all(query)
  end
end
