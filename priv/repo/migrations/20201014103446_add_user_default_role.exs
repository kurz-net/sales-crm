defmodule Dashboard.Repo.Migrations.AddUserDefaultRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :role, :string, default: "rebel"
    end
  end
end
