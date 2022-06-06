defmodule Dashboard.Repo.Migrations.CreateLeads do
  use Ecto.Migration

  def change do
    create table(:leads) do
      add :company_name, :string
      add :contact_name, :string
      add :notes, :text
      add :rebel_id, references(:rebels, on_delete: :nothing)

      timestamps()
    end

    create index(:leads, [:rebel_id])
  end
end
