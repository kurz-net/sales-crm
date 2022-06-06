defmodule Dashboard.Repo.Migrations.RemovePaydatesFromPackets do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      remove :cost
      add :cost, :float
    end
  end
end
