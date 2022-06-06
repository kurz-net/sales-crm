defmodule Dashboard.Finance.Packet do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.Project
  alias Dashboard.Finance.Commission

  schema "packets" do
    field :description, :string
    field :name, :string
    field :cost, :float

    embeds_one :commission, Commission

    belongs_to :project, Project

    timestamps()
  end

  @required_fields [:name, :description, :cost, :commission, :project_id]
  @optional_fields []

  @doc false
  def changeset(packet, attrs) do
    packet
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
