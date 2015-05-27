defmodule CardShark.Card do
  use CardShark.Web, :model

  schema "cards" do
    field :summary, :string
    field :detail, :string
    field :estimate, :integer
    field :assignee, :integer
    belongs_to :project, CardShark.Project

    timestamps
  end

  @required_fields ~w(summary detail estimate assignee)
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
