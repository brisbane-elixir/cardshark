defmodule CardShark.CardController do
  use CardShark.Web, :controller

  alias CardShark.Card

  plug :scrub_params, "card" when action in [:create, :update]
  plug :action

  def create(conn, %{"card" => card_params}) do
    changeset = Card.changeset(%Card{}, card_params)

    if changeset.valid? do
      card = Repo.insert(changeset)
      CardShark.Endpoint.broadcast! "stream", "cardevent", %{event: "created", card: card}
      conn
      |> put_status(:created)
      |> json(card)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> json(changeset)
    end
  end

  def index(conn, _params) do
    json conn, Repo.all(Card)
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get(Card, id)
    if card do
      json conn, card
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get(Card, id)

    if card do
      changeset = Card.changeset(card, card_params)

      if changeset.valid? do
        updated_card = Repo.update(changeset)
        CardShark.Endpoint.broadcast! "stream", "cardevent", %{event: "updated", card: changeset.changes}
        json conn, updated_card
      else
        conn
        |> put_status(:unprocessable_entity)
        |> json(changeset)
      end
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Repo.get(Card, id)
    if card do
      json conn, Repo.delete(card)
    else
      conn
      |> put_status(:not_found)
      |> json %{}
    end
  end
end
