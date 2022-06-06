defmodule Dashboard.Sales.Call do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.Lead
  alias Dashboard.Sales.Documentation
  alias Dashboard.Finance.RebelCredit

  @outcomes [
    "Kein Potenzial",
    "Keine Durchstellung",
    "Nummer ungültig",
    "Wiedervorlage",
    "Keine Zeit",
    "Kein Interesse",
    "Mail senden",
    "Closing Call"
  ]
  def outcomes, do: @outcomes

  schema "calls" do
    field :follow_up, :naive_datetime
    field :length, :integer
    field :outcome, :string

    belongs_to :lead, Lead

    has_one :documentation, Documentation
    has_one :rebel_credit, RebelCredit

    timestamps()
  end

  @required_fields [:length, :outcome, :lead_id]
  @optional_fields [:follow_up]

  @doc false
  def changeset(call, attrs) do
    call
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> cast_assoc(:documentation, with: &Documentation.changeset/2)
    |> validate_required(@required_fields)
    |> validate_inclusion(:outcome, @outcomes)
  end
end
