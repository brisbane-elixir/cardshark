defmodule CardShark.ColumnList do
  alias CardShark.Column

  defmodule Type do
    @behaviour Ecto.Type

    def type, do: :json

    def cast(payload) when is_list(payload), do: {:ok, payload}

    def cast(%{} = payload), do: {:ok, payload}
    def cast(_other),        do: :error

    def load(value) do
      constructed = Poison.decode!(value, keys: :atoms)
                    |> Enum.map(&(struct(Column, &1)))
      {:ok, constructed}
    end

    def dump(value), do: Poison.encode(value)
  end
end
