defmodule CardShark.Card do
  use CardShark.Web, :model

  schema "cards" do
    field :summary, :string
    field :detail, :string
    field :estimate, :integer
    field :assignee, :integer
    field :priority, :float, default: 0.0
    field :status, :string, default: "backlog"
    belongs_to :project, CardShark.Project

    timestamps
  end

  @required_fields ~w(summary status priority)
  @optional_fields ~w(assignee estimate detail)

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
