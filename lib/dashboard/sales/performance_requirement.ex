defmodule Dashboard.Sales.PerformanceRequirement do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.{Partner, Rebel}

  schema "requirements" do
    field :to_date, :date
    field :from_date, :date
    field :calls, :integer
    field :hours, :integer
    belongs_to :rebel, Rebel
    belongs_to :partner, Partner

    timestamps()
  end

  @required_fields [:from_date, :to_date, :partner_id]
  @optional_fields [:calls, :hours, :rebel_id]

  @doc false
  def changeset(performance_requirement, attrs) do
    performance_requirement
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_one_of([:calls, :hours])
  end

  defp validate_one_of(changeset, fields) do
    flag = Enum.any?(fields, fn field ->
      get_field(changeset, field) != nil
    end)

    if flag do
      changeset
    else
      Enum.reduce(fields, changeset, fn el, acc ->
        add_error(acc, el, "at least one of #{Enum.join(fields, ", ")} must be set")
      end)
    end
  end
end
