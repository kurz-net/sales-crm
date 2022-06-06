defmodule Dashboard.Repo.Migrations.AddLeadToProject do
  use Ecto.Migration

  def change do
    alter table(:leads) do
      add :project_id, references(:projects, on_delete: :nothing)
    end
    create index(:leads, [:project_id])
  end
end
