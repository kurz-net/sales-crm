defmodule Dashboard.Repo.Migrations.AddEmbeddedPacketSchemas do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      add :provision, :map
      add :cost, :map
    end
  end
end
