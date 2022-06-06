defmodule Dashboard.Finance.RebelCredit do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Finance
  alias Dashboard.Finance.Packet
  alias Dashboard.Sales.Call

  schema "rebel_credits" do
    belongs_to :packet, Packet
    belongs_to :call, Call

    embeds_many :pay_rates, PayRate do
      field :date, :date
      field :percentage, :boolean
      field :value, :float
    end

    timestamps()
  end

  @required_fields [:packet_id, :call_id]

  @doc false
  def changeset(rebel_credit, attrs) do
    rebel_credit
    |> cast(attrs, @required_fields)
    |> cast_embed(:pay_rates, with: &pay_rate_changeset/2)
    |> validate_required(@required_fields)
    |> validate_rate_sum
  end
  def validate_rate_sum(changeset) do
    case get_field(changeset, :packet_id) do
      nil -> changeset
      packet_id ->
      packet = Finance.get_packet!(packet_id)

      pay_rates = get_field(changeset, :pay_rates)
      IO.inspect pay_rates

      sum = sum_pay_rates(packet, pay_rates)
      if sum != packet.cost do
        changeset
        |> add_error(:pay_rates, "Zahlungen müssen summiert die Kosten des Packets decken")
      else
        changeset
      end
    end
  end

  @doc false
  def pay_rate_changeset(pay_rate, attrs) do
    pay_rate
    |> cast(attrs, [:percentage, :value, :date])
    |> validate_required([:percentage, :value, :date])
  end

  def sum_pay_rates(%Packet{} = packet, %__MODULE__{} = rebel_credit) do
    sum_pay_rates(packet, rebel_credit.pay_rates)
  end

  def sum_pay_rates(%Packet{} = packet, rates) when is_list(rates) do
    Enum.reduce(rates, 0.0, fn current, acc ->
      current_value = if current.value == nil do
        0
      else
        current.value
      end

      value = if current.percentage do
        packet.cost * current_value / 100.0
      else
        current_value
      end
      acc + value
    end)
  end
end
