defmodule CardShark.StreamChannel do
  use Phoenix.Channel
  require Logger

  def join(topic, message, socket) do
    Logger.debug "JOIN: #{socket.channel}:#{topic}:#{inspect message}"
    {:ok, socket}
  end
end
