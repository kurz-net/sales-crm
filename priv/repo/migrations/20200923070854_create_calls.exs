defmodule Dashboard.Repo.Migrations.CreateCalls do
  use Ecto.Migration

  def change do
    create table(:calls) do
      add :contact_name, :string
      add :length, :integer
      add :outcome, :string
      add :follow_up, :naive_datetime
      add :partner_id, references(:partners, on_delete: :nothing, column: :id)
      add :rebel_id, references(:rebels, on_delete: :nothing, column: :id)

      timestamps()
    end

    create index(:calls, [:partner_id])
    create index(:calls, [:rebel_id])
  end
end
