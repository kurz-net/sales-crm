defmodule Dashboard.Entities do
  @moduledoc """
  The Entities context.
  """

  import Ecto.Query, warn: false
  alias Dashboard.Repo

  alias Dashboard.Entities.Rebel

  @doc """
  Returns the list of rebels.

  ## Examples

      iex> list_rebels()
      [%Rebel{}, ...]

  """
  def list_rebels do
    Repo.all(Rebel)
  end

  @doc """
  Gets a single rebel.

  Raises `Ecto.NoResultsError` if the Rebel does not exist.

  ## Examples

      iex> get_rebel!(123)
      %Rebel{}

      iex> get_rebel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rebel!(id), do: Repo.get!(Rebel, id)

  @doc """
  Creates a rebel.

  ## Examples

      iex> create_rebel(%{field: value})
      {:ok, %Rebel{}}

      iex> create_rebel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rebel(attrs \\ %{}) do
    %Rebel{}
    |> Rebel.changeset(attrs)
    |> Repo.insert()
  end

  def register_rebel(attrs \\ %{}) do
    %Rebel{}
    |> Rebel.register_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rebel.

  ## Examples

      iex> update_rebel(rebel, %{field: new_value})
      {:ok, %Rebel{}}

      iex> update_rebel(rebel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rebel(%Rebel{} = rebel, attrs) do
    rebel
    |> Rebel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rebel.

  ## Examples

      iex> delete_rebel(rebel)
      {:ok, %Rebel{}}

      iex> delete_rebel(rebel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rebel(%Rebel{} = rebel) do
    Repo.delete(rebel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rebel changes.

  ## Examples

      iex> change_rebel(rebel)
      %Ecto.Changeset{data: %Rebel{}}

  """
  def change_rebel(%Rebel{} = rebel, attrs \\ %{}) do
    Rebel.changeset(rebel, attrs)
  end

  def change_register_rebel(%Rebel{} = rebel, attrs \\ %{}) do
    Rebel.register_changeset(rebel, attrs)
  end

  alias Dashboard.Entities.Partner

  @doc """
  Returns the list of partners.

  ## Examples

      iex> list_partners()
      [%Partner{}, ...]

  """
  def list_partners do
    Repo.all(Partner)
  end

  @doc """
  Gets a single partner.

  Raises `Ecto.NoResultsError` if the Partner does not exist.

  ## Examples

      iex> get_partner!(123)
      %Partner{}

      iex> get_partner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partner!(id), do: Repo.get!(Partner, id)

  @doc """
  Creates a partner.

  ## Examples

      iex> create_partner(%{field: value})
      {:ok, %Partner{}}

      iex> create_partner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partner.

  ## Examples

      iex> update_partner(partner, %{field: new_value})
      {:ok, %Partner{}}

      iex> update_partner(partner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partner(%Partner{} = partner, attrs) do
    partner
    |> Partner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a partner.

  ## Examples

      iex> delete_partner(partner)
      {:ok, %Partner{}}

      iex> delete_partner(partner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partner(%Partner{} = partner) do
    Repo.delete(partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partner changes.

  ## Examples

      iex> change_partner(partner)
      %Ecto.Changeset{data: %Partner{}}

  """
  def change_partner(%Partner{} = partner, attrs \\ %{}) do
    Partner.changeset(partner, attrs)
  end

  alias Dashboard.Entities.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  def get_rebel_requirements(%Rebel{} = rebel) do
    rebel = Repo.preload(rebel, [projects: [partner: [requirements: [partner: [projects: [leads: [calls: [:lead]]]]]]]])

    rebel.projects
    |> Enum.map(fn project -> project.partner end)
    |> Enum.uniq_by(fn partner -> partner.id end)
    |> Enum.map(fn partner ->
      partner.requirements
      |> Enum.filter(fn r ->
        is_nil(r.rebel_id) or r.rebel_id == rebel.id
      end)
      |> Enum.filter(fn r ->
        Date.range(r.from_date, r.to_date)
        |> Enum.member?(Date.utc_today)
      end)
    end)
    |> Enum.map(fn reqs ->
      if Enum.any?(reqs, fn r -> r.rebel_id end) do
        Enum.filter(reqs, fn r -> r.rebel_id end)
      else
        reqs
      end
    end)
    |> Enum.flat_map(fn r -> r end)
  end

  alias Dashboard.Entities.Lead

  @doc """
  Returns the list of leads.

  ## Examples

      iex> list_leads()
      [%Lead{}, ...]

  """
  def list_leads do
    Repo.all(Lead)
  end

  @doc """
  Gets a single lead.

  Raises `Ecto.NoResultsError` if the Lead does not exist.

  ## Examples

      iex> get_lead!(123)
      %Lead{}

      iex> get_lead!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lead!(id), do: Repo.get!(Lead, id)

  @doc """
  Creates a lead.

  ## Examples

      iex> create_lead(%{field: value})
      {:ok, %Lead{}}

      iex> create_lead(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lead(attrs \\ %{}) do
    %Lead{}
    |> Lead.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lead.

  ## Examples

      iex> update_lead(lead, %{field: new_value})
      {:ok, %Lead{}}

      iex> update_lead(lead, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lead(%Lead{} = lead, attrs) do
    lead
    |> Lead.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lead.

  ## Examples

      iex> delete_lead(lead)
      {:ok, %Lead{}}

      iex> delete_lead(lead)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lead(%Lead{} = lead) do
    Repo.delete(lead)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lead changes.

  ## Examples

      iex> change_lead(lead)
      %Ecto.Changeset{data: %Lead{}}

  """
  def change_lead(%Lead{} = lead, attrs \\ %{}) do
    Lead.changeset(lead, attrs)
  end

  def get_rebel_calls(%Rebel{} = rebel) do
    rebel =
      rebel
      |> Repo.preload(leads: [:calls])

    rebel.leads
    |> Enum.map(&(&1.calls))
    |> Enum.flat_map(fn c -> c end)
  end
end
