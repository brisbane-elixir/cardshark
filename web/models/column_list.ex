defmodule CardShark.ColumnList do
  defmodule Type do
    @behaviour Ecto.Type

    def type, do: :json

    def cast(payload) when is_list(payload), do: {:ok, payload}
    def cast(%{} = payload), do: {:ok, payload}
    def cast(_other),        do: :error

    def load(value), do: Poison.decode(value, keys: :atoms!)

    def dump(value), do: Poison.encode(value)
  end
end
