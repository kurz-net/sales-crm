defmodule Dashboard.Repo.Migrations.AddMigrationOtherDefaultValue do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      modify :other, :string, default: ""
    end
  end
end
