defmodule Dashboard.Repo.Migrations.UpdateRebelCreditCallId do
  use Ecto.Migration

  def change do
    alter table(:rebel_credits) do
      add :call_id, references(:calls, on_delete: :nothing)
    end
    create index(:rebel_credits, [:call_id])
  end
end
