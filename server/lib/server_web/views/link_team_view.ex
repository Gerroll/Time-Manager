defmodule ServerWeb.LinkTeamView do
  use ServerWeb, :view
  alias ServerWeb.LinkTeamView

  def render("index.json", %{linkteams: linkteams}) do
    %{data: render_many(linkteams, LinkTeamView, "link_team.json")}
  end

  def render("show.json", %{link_team: link_team}) do
    %{data: render_one(link_team, LinkTeamView, "link_team.json")}
  end

  def render("link_team.json", %{link_team: link_team}) do
    %{id: link_team.id,
      manager: link_team.manager}
  end
end
