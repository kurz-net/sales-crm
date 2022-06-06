defmodule Dashboard.Entities.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.{Partner, Rebel, Lead}
  alias Dashboard.Sales.ProjectRebel
  alias Dashboard.Finance.Packet

  schema "projects" do
    field :name, :string
    field :start_date, :date
    field :end_date, :date

    belongs_to :partner, Partner

    has_many :packets, Packet
    has_many :leads, Lead

    many_to_many :rebels, Rebel, join_through: ProjectRebel

    timestamps()
  end

  @required_fields [:name, :partner_id]
  @optional_fields [:start_date, :end_date]

  @doc false
  def changeset_add_rebels(project, rebels) do
    project
    |> cast(%{}, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> put_assoc(:rebels, rebels)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
