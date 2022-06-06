defmodule Dashboard.Accounts.ActivationCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activation_codes" do
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(activation_code, attrs) do
    activation_code
    |> cast(attrs, [:code])
    |> validate_required([:code])
  end
end
