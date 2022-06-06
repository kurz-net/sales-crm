defmodule Dashboard.Repo.Migrations.CreateActivationCodes do
  use Ecto.Migration

  def change do
    create table(:activation_codes) do
      add :code, :string

      timestamps()
    end

  end
end
