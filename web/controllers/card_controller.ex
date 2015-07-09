defmodule CardShark.CardController do
  use CardShark.Web, :controller

  alias CardShark.Card

  plug :scrub_params, "card" when action in [:create, :update]

  def index(conn, _params) do
    cards = Repo.all(Card)
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    changeset = Card.changeset(%Card{}, card_params)

    if changeset.valid? do
      card = Repo.insert!(changeset)
      CardShark.Endpoint.broadcast! "stream", "cardevent", %{event: "created", card: card}
      render(conn, "show.json", card: card)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    render conn, "show.json", card: card
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card, card_params)

    if changeset.valid? do
      card = Repo.update!(changeset)
      CardShark.Endpoint.broadcast! "stream", "cardevent", %{event: "updated", card: changeset.changes}
      render(conn, "show.json", card: card)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)

    card = Repo.delete!(card)
    render(conn, "show.json", card: card)
  end
end
