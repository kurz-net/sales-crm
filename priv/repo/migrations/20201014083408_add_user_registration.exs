defmodule Dashboard.Repo.Migrations.AddUserRegistration do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :code, :string
    end
  end
end
