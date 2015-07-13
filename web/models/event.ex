defmodule CardShark.Event do
  use CardShark.Web, :model
  alias CardShark.Repo
  alias CardShark.Event

  schema "events" do
    field :name, :string
    field :payload, CardShark.EventPayload.Type
    field :timestamp, Ecto.DateTime, default: Ecto.DateTime.utc
  end

  @required_fields ~w(name payload timestamp)
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

  def card_created(card) do
      payload = card
      |> Map.take([:id, :summary, :detail, :estimate, :assignee, :project_id])

      %Event{
        name: "card_created",
        payload: payload
      }
  end

  def store(event) do
    event |> Repo.insert!
  end
end
