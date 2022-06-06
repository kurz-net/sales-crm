defmodule Dashboard.Metrics.RebelWorkQuota do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.Rebel

  schema "rebel_work_quotas" do
    field :hours, :float
    field :from_date, :date
    field :to_date, :date

    belongs_to :rebel, Rebel

    timestamps()
  end

  @required_fields [:hours, :from_date, :to_date, :rebel_id]

  @doc false
  def changeset(rebel_work_quota, attrs) do
    rebel_work_quota
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
