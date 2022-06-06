defmodule Dashboard.Repo.Migrations.CreatePackets do
  use Ecto.Migration

  def change do
    create table(:packets) do
      add :name, :string
      add :description, :text
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:packets, [:project_id])
  end
end
