defmodule CardShark.CardView do
  use CardShark.Web, :view

  def render("index.json", %{cards: cards}) do
    %{cards: render_many(cards, "card.json")}
  end

  def render("show.json", %{card: card}) do
    render_one(card, "card.json")
  end

  def render("card.json", %{card: card}) do
    %{
      id: card.id,
      summary: card.summary,
      detail: card.detail,
      estimate: card.estimate,
      assignee: card.assignee,
      priority: card.priority,
      status: card.status
    }
  end
end
