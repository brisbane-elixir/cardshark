defmodule CardShark.Repo.Migrations.AddDisplayColumnsToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :display_columns, {:array, :string}
    end
  end
end
