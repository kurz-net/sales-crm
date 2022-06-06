defmodule Dashboard.Repo.Migrations.AddRebelCreditsPayRate do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      add :pay_rates, {:array, :map}
    end
  end
end
