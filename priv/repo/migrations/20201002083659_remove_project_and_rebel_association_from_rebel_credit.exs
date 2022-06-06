defmodule Dashboard.Repo.Migrations.RemoveProjectAndRebelAssociationFromRebelCredit do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      remove :project_id
      remove :rebel_id
    end
  end
end
