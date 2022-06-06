defmodule Dashboard.Repo.Migrations.AddBrancheToDocumentation do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      add :branche, :string
    end
  end
end
