defmodule ServerWeb.RankView do
  use ServerWeb, :view
  alias ServerWeb.RankView

  def render("index.json", %{ranks: ranks}) do
    %{data: render_many(ranks, RankView, "rank.json")}
  end

  def render("show.json", %{rank: rank}) do
    %{data: render_one(rank, RankView, "rank.json")}
  end

  def render("rank.json", %{rank: rank}) do
    %{id: rank.id,
      name: rank.name}
  end
end
