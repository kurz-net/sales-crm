defmodule Dashboard.Repo.Migrations.AddPayRatesToCredit do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      add :pay_rates, :map
    end
  end
end
