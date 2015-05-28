defmodule CardShark.StreamChannel do
  use Phoenix.Channel
  require Logger

  def join(topic, message, socket) do
    {:ok, %{}, socket}
  end
end
