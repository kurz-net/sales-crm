defmodule Dashboard.Repo.Migrations.ChangeSessionStartToEnd do
  use Ecto.Migration

  def change do
    alter table(:rebel_sessions) do
      remove :start
      add :end, :naive_datetime
    end
  end
end
