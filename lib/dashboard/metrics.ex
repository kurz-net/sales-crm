defmodule Dashboard.Metrics do
  @moduledoc """
  The Metrics context.
  """

  import Ecto.Query, warn: false
  alias Dashboard.Repo

  alias Dashboard.Metrics.RebelWorkQuota

  @doc """
  Returns the list of rebel_work_quotas.

  ## Examples

      iex> list_rebel_work_quotas()
      [%RebelWorkQuota{}, ...]

  """
  def list_rebel_work_quotas do
    Repo.all(RebelWorkQuota)
  end

  @doc """
  Gets a single rebel_work_quota.

  Raises `Ecto.NoResultsError` if the Rebel work quota does not exist.

  ## Examples

      iex> get_rebel_work_quota!(123)
      %RebelWorkQuota{}

      iex> get_rebel_work_quota!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rebel_work_quota!(id), do: Repo.get!(RebelWorkQuota, id)

  @doc """
  Creates a rebel_work_quota.

  ## Examples

      iex> create_rebel_work_quota(%{field: value})
      {:ok, %RebelWorkQuota{}}

      iex> create_rebel_work_quota(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rebel_work_quota(attrs \\ %{}) do
    %RebelWorkQuota{}
    |> RebelWorkQuota.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rebel_work_quota.

  ## Examples

      iex> update_rebel_work_quota(rebel_work_quota, %{field: new_value})
      {:ok, %RebelWorkQuota{}}

      iex> update_rebel_work_quota(rebel_work_quota, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rebel_work_quota(%RebelWorkQuota{} = rebel_work_quota, attrs) do
    rebel_work_quota
    |> RebelWorkQuota.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rebel_work_quota.

  ## Examples

      iex> delete_rebel_work_quota(rebel_work_quota)
      {:ok, %RebelWorkQuota{}}

      iex> delete_rebel_work_quota(rebel_work_quota)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rebel_work_quota(%RebelWorkQuota{} = rebel_work_quota) do
    Repo.delete(rebel_work_quota)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rebel_work_quota changes.

  ## Examples

      iex> change_rebel_work_quota(rebel_work_quota)
      %Ecto.Changeset{data: %RebelWorkQuota{}}

  """
  def change_rebel_work_quota(%RebelWorkQuota{} = rebel_work_quota, attrs \\ %{}) do
    RebelWorkQuota.changeset(rebel_work_quota, attrs)
  end
end
