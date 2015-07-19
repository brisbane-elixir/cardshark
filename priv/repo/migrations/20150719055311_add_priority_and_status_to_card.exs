defmodule CardShark.Repo.Migrations.AddPriorityAndStatusToCard do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :priority, :real
      add :status, :string
    end
  end
end
