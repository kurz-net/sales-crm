defmodule Dashboard.Repo.Migrations.MakeDocumentationPainsAText do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      modify :pains, :text
    end
  end
end
