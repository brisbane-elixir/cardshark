defmodule CardShark.StreamChannel do
  use Phoenix.Channel
  import Ecto.Query
  require Logger

  def join(topic, message, socket) do
    query = from c in CardShark.Card, order_by: [desc: c.priority]
    cards = CardShark.Repo.all query
    {:ok, cards, socket}
  end
end
