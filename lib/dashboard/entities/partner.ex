defmodule Dashboard.Entities.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.Project
  alias Dashboard.Sales.PerformanceRequirement

  schema "partners" do
    field :name, :string

    has_many :projects, Project
    has_many :requirements, PerformanceRequirement

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
