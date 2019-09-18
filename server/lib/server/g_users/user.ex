defmodule Server.GUsers.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string
    field :rank, :string
    field :username, :string
    field :token, :string
    field :expire_token, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :rank, :token, :expire_token])
    |> validate_required([:username, :email, :password, :rank])
    # |> cast(attrs, [:username, :email, :password, :rank])
    # |> validate_required([:username, :email, :password, :rank])
  end
end
