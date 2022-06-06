defmodule Dashboard.Repo.Migrations.RemoveContinuationFromDocumentation do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      remove :continuation
    end
  end
end
