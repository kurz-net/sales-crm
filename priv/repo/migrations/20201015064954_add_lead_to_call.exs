defmodule Dashboard.Repo.Migrations.AddLeadToCall do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      add :lead_id, references(:leads, on_delete: :nothing, column: :id)
    end
    create index(:calls, [:lead_id])
  end
end
