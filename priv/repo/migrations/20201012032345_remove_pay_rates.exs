defmodule Dashboard.Repo.Migrations.RemovePayRates do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      remove :pay_rates
    end
  end
end
