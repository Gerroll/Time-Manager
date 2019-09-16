defmodule Server do
  @moduledoc """
  Server keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  use Application
  import Server.GRanks
  def start(_type, _args) do
    # list_rank = ["employee", "manager", "general_manager"]
    # teams = Server.GRanks.list_ranks()
    # employee = Enum.any?(teams, fn(t) -> t.name == list_rank[0] end)
    # # if !employee, :do Server.GRanks.create_rank(%{name: "employee"})
    # IO.inspect employee
    # if !employee do
    #   Server.GRanks.create_rank(%{name: "employee"})
    # end
  end
  # Server.GRanks.create_rank(%{name: "manager"})
  # Server.GRanks.create_rank(%{name: "general_manager"})

end
