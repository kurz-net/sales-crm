defmodule Dashboard.Repo.Migrations.MakeDocumentationTexts do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      modify :data, :text
      modify :pains, :text
      modify :other, :text
    end
  end
end
