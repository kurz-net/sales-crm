defmodule Dashboard.Repo.Migrations.CreateRebels do
  use Ecto.Migration

  def change do
    create table(:rebels) do
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

  end
end
