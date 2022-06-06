defmodule Dashboard.Sales.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.Rebel

  schema "rebel_sessions" do
    field :end, :naive_datetime

    belongs_to :rebel, Rebel

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:rebel_id, :end])
    |> validate_required([:rebel_id])
  end
end
