defmodule CardShark.CardView do
  use CardShark.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{id: card.id}
  end
end
