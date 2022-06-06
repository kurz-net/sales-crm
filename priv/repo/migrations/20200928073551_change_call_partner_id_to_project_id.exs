defmodule Dashboard.Repo.Migrations.ChangeCallPartnerIdToProjectId do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      remove :partner_id
      add :project_id, references(:projects, on_delete: :nothing, column: :id)
    end
    create index(:calls, [:project_id])
  end
end
