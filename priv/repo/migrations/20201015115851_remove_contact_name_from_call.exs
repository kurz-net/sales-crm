defmodule Dashboard.Repo.Migrations.RemoveContactNameFromCall do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      remove :contact_name
    end
  end
end
