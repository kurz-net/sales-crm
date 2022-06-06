defmodule Dashboard.Sales.Documentation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Sales.Call

  schema "documentations" do
    field :data, :string
    field :disc, :string
    field :branche, :string
    field :pains, :string
    field :other, :string, default: ""

    belongs_to :call, Call

    timestamps()
  end

  @required_fields []
  @optional_fields [:disc, :branche, :other, :data, :pains]

  @doc false
  def changeset(documentation, attrs) do
    documentation
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
