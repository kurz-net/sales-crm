defmodule Dashboard.Finance.Commission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dashboard.Finance.Commission

  embedded_schema do
    field :percentage, :boolean, default: false
    field :value, :float
  end

  @doc false
  def changeset(%Commission{} = commission, attrs) do
    commission
    |> cast(attrs, [:percentage, :value])
    |> validate_required([:percentage, :value])
  end
end
