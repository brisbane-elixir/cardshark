defmodule CardShark.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :payload, :json
      add :timestamp, :datetime
    end

  end
end
