defmodule Dashboard.Repo.Migrations.UpdateProjectToDates do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      modify :start_date, :date
      modify :end_date, :date
    end
  end
end
