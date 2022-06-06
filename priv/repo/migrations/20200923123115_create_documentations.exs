defmodule Dashboard.Repo.Migrations.CreateDocumentations do
  use Ecto.Migration

  def change do
    create table(:documentations) do
      add :disc, :string
      add :data, :string
      add :pains, {:array, :string}
      add :continuation, :string
      add :call_id, references(:calls, on_delete: :nothing)

      timestamps()
    end

    create index(:documentations, [:call_id])
  end
end
