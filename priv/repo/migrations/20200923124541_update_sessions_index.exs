defmodule Dashboard.Repo.Migrations.UpdateSessionsIndex do
  use Ecto.Migration

  def change do
    drop index(:sessions, [:rebel_id])
    create index(:rebel_sessions, [:rebel_id])
  end
end
