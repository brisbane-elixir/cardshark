defmodule CardShark.CardController do
  use CardShark.Web, :controller

  import Ecto.Query

  alias CardShark.Card
  alias CardShark.Event
  alias CardShark.Commands

  plug :scrub_params, "card" when action in [:create, :update]

  def index(conn, _params) do
    query = from c in Card, order_by: [desc: c.priority]
    cards = Repo.all query
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    %Commands.CreateCard{card_params: card_params}
    |> CommandExecutor.execute
    |> render_create_result(conn)
  end

  def render_create_result({:ok, card}, conn) do
    render(conn, "show.json", card: card)
  end

  def render_create_result({:error, changeset}, conn) do
      conn
      |> put_status(:unprocessable_entity)
      |> render(CardShark.ChangesetView, "error.json", changeset: changeset)
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
