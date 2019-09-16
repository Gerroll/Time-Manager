defmodule Server.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :rank, :string
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:team_id])
  end
end
