defmodule Dashboard.Repo.Migrations.CreateRebelWorkQuotas do
  use Ecto.Migration

  def change do
    create table(:rebel_work_quotas) do
      add :hours, :float
      add :from_date, :date
      add :to_date, :date
      add :rebel_id, references(:rebels, on_delete: :nothing)

      timestamps()
    end

    create index(:rebel_work_quotas, [:rebel_id])
  end
end
