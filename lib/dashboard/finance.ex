defmodule Dashboard.Finance do
  @moduledoc """
  The Finance context.
  """

  import Ecto.Query, warn: false
  alias Dashboard.Repo

  alias Dashboard.Finance.Packet

  @doc """
  Returns the list of packets.

  ## Examples

      iex> list_packets()
      [%Packet{}, ...]

  """
  def list_packets do
    Repo.all(Packet)
  end

  @doc """
  Gets a single packet.

  Raises `Ecto.NoResultsError` if the Packet does not exist.

  ## Examples

      iex> get_packet!(123)
      %Packet{}

      iex> get_packet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_packet!(id), do: Repo.get!(Packet, id)

  @doc """
  Creates a packet.

  ## Examples

      iex> create_packet(%{field: value})
      {:ok, %Packet{}}

      iex> create_packet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_packet(attrs \\ %{}) do
    %Packet{}
    |> Packet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a packet.

  ## Examples

      iex> update_packet(packet, %{field: new_value})
      {:ok, %Packet{}}

      iex> update_packet(packet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_packet(%Packet{} = packet, attrs) do
    packet
    |> Packet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a packet.

  ## Examples

      iex> delete_packet(packet)
      {:ok, %Packet{}}

      iex> delete_packet(packet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_packet(%Packet{} = packet) do
    Repo.delete(packet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking packet changes.

  ## Examples

      iex> change_packet(packet)
      %Ecto.Changeset{data: %Packet{}}

  """
  def change_packet(%Packet{} = packet, attrs \\ %{}) do
    Packet.changeset(packet, attrs)
  end

  alias Dashboard.Finance.RebelCredit

  @doc """
  Returns the list of rebel_credits.

  ## Examples

      iex> list_rebel_credits()
      [%RebelCredit{}, ...]

  """
  def list_rebel_credits do
    Repo.all(RebelCredit)
  end

  @doc """
  Gets a single rebel_credit.

  Raises `Ecto.NoResultsError` if the Rebel credit does not exist.

  ## Examples

      iex> get_rebel_credit!(123)
      %RebelCredit{}

      iex> get_rebel_credit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rebel_credit!(id), do: Repo.get!(RebelCredit, id)

  @doc """
  Creates a rebel_credit.

  ## Examples

      iex> create_rebel_credit(%{field: value})
      {:ok, %RebelCredit{}}

      iex> create_rebel_credit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rebel_credit(attrs \\ %{}) do
    %RebelCredit{}
    |> RebelCredit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rebel_credit.

  ## Examples

      iex> update_rebel_credit(rebel_credit, %{field: new_value})
      {:ok, %RebelCredit{}}

      iex> update_rebel_credit(rebel_credit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rebel_credit(%RebelCredit{} = rebel_credit, attrs) do
    rebel_credit
    |> RebelCredit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rebel_credit.

  ## Examples

      iex> delete_rebel_credit(rebel_credit)
      {:ok, %RebelCredit{}}

      iex> delete_rebel_credit(rebel_credit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rebel_credit(%RebelCredit{} = rebel_credit) do
    Repo.delete(rebel_credit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rebel_credit changes.

  ## Examples

      iex> change_rebel_credit(rebel_credit)
      %Ecto.Changeset{data: %RebelCredit{}}

  """
  def change_rebel_credit(%RebelCredit{} = rebel_credit, attrs \\ %{}) do
    RebelCredit.changeset(rebel_credit, attrs)
  end

  def calculate_credit(%RebelCredit{} = credit) do
    credit = credit
             |> Repo.preload([:packet])

    commission = credit.packet.commission
    cost = credit.packet.cost

    if commission.percentage do
      cost * commission.value / 100.0
    else
      commission.value
    end
  end
end
