ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(CardShark.Repo)

defmodule TestHelper do
  import Ecto.Query
  alias CardShark.Event
  alias CardShark.Repo

  def latest_event(event_name) do
    from(e in Event,
      where: e.name == ^event_name,
      order_by: [desc: e.timestamp]
    ) |> Repo.one
  end
end
