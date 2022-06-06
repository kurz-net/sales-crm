defmodule Dashboard.Repo.Migrations.AlterDiscAsArray do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      remove :disc
      add :disc, {:array, :string}
    end
  end
end
