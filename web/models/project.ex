defmodule CardShark.Project do
  use CardShark.Web, :model

  schema "projects" do
    field :name, :string
    field :display_columns, {:array, :string}
    has_many :cards, CardShark.Card

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
