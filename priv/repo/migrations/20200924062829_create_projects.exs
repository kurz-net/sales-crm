defmodule Dashboard.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :start_date, :naive_datetime
      add :end_date, :naive_datetime
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:partner_id])
  end
end
