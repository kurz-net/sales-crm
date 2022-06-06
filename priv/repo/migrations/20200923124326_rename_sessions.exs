defmodule Dashboard.Repo.Migrations.RenameSessions do
  use Ecto.Migration

  def change do
    rename table(:sessions), to: table(:rebel_sessions)
  end
end
