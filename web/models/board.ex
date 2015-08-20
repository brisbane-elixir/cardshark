defmodule CardShark.Board do
  use CardShark.Web, :model

  schema "boards" do
    field :name, :string
    field :columns, CardShark.ColumnList.Type
    belongs_to :project, CardShark.Project

    timestamps
  end

  @required_fields ~w(name columns project_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
