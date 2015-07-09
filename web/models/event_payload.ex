defmodule CardShark.EventPayload do
  defmodule Type do
    @behaviour Ecto.Type

    def type, do: :json

    def cast(%{} = payload), do: {:ok, payload}
    def cast(_other),        do: :error

    def load(value), do: Poison.decode(value)

    def dump(value), do: Poison.encode(value)
  end
end
