defmodule CardShark.Repo.Migrations.CreateBoard do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string
      add :columns, :json
      add :project_id, :integer

      timestamps
    end

  end
end
