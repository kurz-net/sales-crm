defmodule Dashboard.Repo.Migrations.CreateEmail do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password, :string
      add :role, :string
      add :rebel_id, references(:rebels, on_delete: :nothing)
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:rebel_id])
    create index(:users, [:partner_id])
  end
end
