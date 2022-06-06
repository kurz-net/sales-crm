defmodule Dashboard.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :start, :naive_datetime
      add :rebel_id, references(:rebels, on_delete: :nothing, column: :id)

      timestamps()
    end

    create index(:sessions, [:rebel_id])
  end
end
