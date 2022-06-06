defmodule Dashboard.Repo.Migrations.CreateRebelCredits do
  use Ecto.Migration

  def change do
    create table(:rebel_credits) do
      add :project_id, references(:projects, on_delete: :nothing)
      add :packet_id, references(:packets, on_delete: :nothing)
      add :rebel_id, references(:rebels, on_delete: :nothing)

      timestamps()
    end

    create index(:rebel_credits, [:project_id])
    create index(:rebel_credits, [:packet_id])
    create index(:rebel_credits, [:rebel_id])
  end
end
