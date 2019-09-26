defmodule Server.Repo do
  use Ecto.Repo, 
    otp_app: :server,
    adapter: Ecto.Adapters.Postgres

  def init(_, config) do
    config = cond do
      System.get_env("PGUSER") != nil and System.get_env("PGPASSWORD") != nil and System.get_env("PGDATABASE") != nil and System.get_env("PGHOST") != nil and System.get_env("PGPORT") != nil
      -> config
        |> Keyword.put(:username, System.get_env("PGUSER"))
        |> Keyword.put(:password, System.get_env("PGPASSWORD"))
        |> Keyword.put(:database, System.get_env("PGDATABASE"))
        |> Keyword.put(:hostname, System.get_env("PGHOST"))
        |> Keyword.put(:port, System.get_env("PGPORT") |> String.to_integer)
      true -> config
    end
    {:ok, config}
  end
end
