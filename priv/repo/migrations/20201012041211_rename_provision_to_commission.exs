defmodule Dashboard.Repo.Migrations.RenameProvisionToCommission do
  use Ecto.Migration

  def change do
    rename table(:packets), :provision, to: :commission
  end
end
