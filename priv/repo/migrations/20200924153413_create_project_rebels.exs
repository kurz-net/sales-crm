defmodule Dashboard.Repo.Migrations.CreateProjectRebels do
  use Ecto.Migration

  def change do
    create table(:project_rebels) do
      add :project_id, references(:projects, on_delete: :nothing)
      add :rebel_id, references(:rebels, on_delete: :nothing)

      timestamps()
    end

    create index(:project_rebels, [:project_id])
    create index(:project_rebels, [:rebel_id])
  end
end
