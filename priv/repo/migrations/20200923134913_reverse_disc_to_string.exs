defmodule Dashboard.Repo.Migrations.ReverseDiscToString do
  use Ecto.Migration

  def change do
    alter table(:documentations) do
      modify :disc, :string
    end
  end
end
