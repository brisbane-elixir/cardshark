defmodule CardShark.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :summary, :string
      add :detail, :text
      add :estimate, :integer
      add :assignee, :integer

      timestamps
    end

  end
end
