defmodule Server.GLinkTeams.LinkTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linkteams" do
    field :manager, :boolean
    field :team_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(link_team, attrs) do
    link_team
    |> cast(attrs, [:team_id, :user_id, :manager])
    |> validate_required([:team_id, :user_id, :manager])
  end
end
