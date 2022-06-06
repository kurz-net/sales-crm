defmodule Dashboard.Repo.Migrations.AddDocumentation do
  use Ecto.Migration

  def change do
    alter table(:calls) do
      add :documentation, :text
    end
  end
end
