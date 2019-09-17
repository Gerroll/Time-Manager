defmodule Server.GLinkTeams.LinkTeam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linkteams" do
    field :manager, :boolean, default: false
    field :team_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(link_team, attrs) do
    link_team
    |> cast(attrs, [:manager])
    |> validate_required([:manager])
  end
end
