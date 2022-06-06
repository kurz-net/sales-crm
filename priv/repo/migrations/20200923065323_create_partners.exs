defmodule Dashboard.Repo.Migrations.CreatePartners do
  use Ecto.Migration

  def change do
    create table(:partners) do
      add :name, :string

      timestamps()
    end

  end
end
