defmodule Dashboard.Repo.Migrations.ChangePayRatesArrayOfMaps do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      remove :pay_rates
      add :pay_rates, {:array, :map}
    end
  end
end
