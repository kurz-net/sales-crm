defmodule Dashboard.Repo.Migrations.UpdateDocumentation do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      remove :documentation
    end
  end
end
