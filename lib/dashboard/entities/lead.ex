defmodule Dashboard.Entities.Lead do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.{Rebel, Project}
  alias Dashboard.Sales.Call

  schema "leads" do
    field :company_name, :string
    field :contact_name, :string
    field :notes, :string

    belongs_to :rebel, Rebel
    belongs_to :project, Project

    has_many :calls, Call

    timestamps()
  end

  @required_fields [:company_name, :contact_name, :project_id]
  @optional_fields [:notes, :rebel_id]

  @doc false
  def changeset(lead, attrs) do
    lead
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def last_outcome(%__MODULE__{} = lead) do
    case List.last lead.calls do
      nil -> nil
      call ->
        call.outcome
    end
  end
end
