defmodule Server.Repo.Migrations.CreateLinkteams do
  use Ecto.Migration

  def change do
    create table(:linkteams) do
      add :manager, :boolean, default: false, null: false
      add :team_id, references(:teams, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:linkteams, [:team_id])
    create index(:linkteams, [:user_id])
  end
end
