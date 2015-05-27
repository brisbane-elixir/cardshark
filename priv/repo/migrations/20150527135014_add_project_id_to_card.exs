defmodule CardShark.Repo.Migrations.AddProjectIdToCard do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :project_id, :integer
    end
  end
end
