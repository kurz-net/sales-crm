defmodule Dashboard.Repo.Migrations.UpdateDocumentationOther do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      add :other, :text
    end
  end
end
