defmodule CardShark.Extensions.Json do
  alias Postgrex.TypeInfo

  @behaviour Postgrex.Extension
  @json ["json", "jsonb"]

  def init(_parameters, opts),
    do: Keyword.fetch!(opts, :library)

  def matching(_library),
    do: [type: "json", type: "jsonb"]

  def format(_library),
    do: :binary

  def encode(%TypeInfo{type: type}, map, _state, library) when type in @json,
    do: library.encode!(map)

  def decode(%TypeInfo{type: type}, json, _state, library) when type in @json,
    do: library.decode!(json)
end
