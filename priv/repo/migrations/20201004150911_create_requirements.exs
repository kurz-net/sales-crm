defmodule Dashboard.Repo.Migrations.CreateRequirements do
  use Ecto.Migration

  def change do
    create table(:requirements) do
      add :from_date, :date
      add :to_date, :date
      add :calls, :integer
      add :hours, :integer
      add :rebel_id, references(:rebels, on_delete: :nothing)
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:requirements, [:rebel_id])
    create index(:requirements, [:partner_id])
  end
end
