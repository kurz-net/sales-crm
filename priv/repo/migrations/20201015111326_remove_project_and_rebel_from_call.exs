defmodule Dashboard.Repo.Migrations.RemoveProjectAndRebelFromCall do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      remove :rebel_id
      remove :project_id
    end
  end
end
