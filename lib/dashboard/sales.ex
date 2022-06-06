defmodule Dashboard.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias Dashboard.Repo

  alias Dashboard.Sales.Call
  alias Dashboard.Entities.{Rebel, Project}

  @doc """
  Returns the list of calls.

  ## Examples

      iex> list_calls()
      [%Call{}, ...]

  """
  def list_calls do
    Repo.all(Call)
  end

  @doc """
  Gets a single call.

  Raises `Ecto.NoResultsError` if the Call does not exist.

  ## Examples

      iex> get_call!(123)
      %Call{}

      iex> get_call!(456)
      ** (Ecto.NoResultsError)

  """
  def get_call!(id), do: Repo.get!(Call, id)

  @doc """
  Creates a call.

  ## Examples

      iex> create_call(%{field: value})
      {:ok, %Call{}}

      iex> create_call(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_call(attrs \\ %{}) do
    %Call{}
    |> Call.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a call.

  ## Examples

      iex> update_call(call, %{field: new_value})
      {:ok, %Call{}}

      iex> update_call(call, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_call(%Call{} = call, attrs) do
    call
    |> Call.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a call.

  ## Examples

      iex> delete_call(call)
      {:ok, %Call{}}

      iex> delete_call(call)
      {:error, %Ecto.Changeset{}}

  """
  def delete_call(%Call{} = call) do
    Repo.delete(call)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking call changes.

  ## Examples

      iex> change_call(call)
      %Ecto.Changeset{data: %Call{}}

  """
  def change_call(%Call{} = call, attrs \\ %{}) do
    Call.changeset(call, attrs)
  end

  alias Dashboard.Sales.Session

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions do
    Repo.all(Session)
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end

  alias Dashboard.Sales.Documentation

  @doc """
  Returns the list of documentations.

  ## Examples

      iex> list_documentations()
      [%Documentation{}, ...]

  """
  def list_documentations do
    Repo.all(Documentation)
  end

  @doc """
  Gets a single documentation.

  Raises `Ecto.NoResultsError` if the Documentation does not exist.

  ## Examples

      iex> get_documentation!(123)
      %Documentation{}

      iex> get_documentation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_documentation!(id), do: Repo.get!(Documentation, id)

  @doc """
  Creates a documentation.

  ## Examples

      iex> create_documentation(%{field: value})
      {:ok, %Documentation{}}

      iex> create_documentation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_documentation(attrs \\ %{}) do
    %Documentation{}
    |> Documentation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a documentation.

  ## Examples

      iex> update_documentation(documentation, %{field: new_value})
      {:ok, %Documentation{}}

      iex> update_documentation(documentation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_documentation(%Documentation{} = documentation, attrs) do
    documentation
    |> Documentation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a documentation.

  ## Examples

      iex> delete_documentation(documentation)
      {:ok, %Documentation{}}

      iex> delete_documentation(documentation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_documentation(%Documentation{} = documentation) do
    Repo.delete(documentation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking documentation changes.

  ## Examples

      iex> change_documentation(documentation)
      %Ecto.Changeset{data: %Documentation{}}

  """
  def change_documentation(%Documentation{} = documentation, attrs \\ %{}) do
    Documentation.changeset(documentation, attrs)
  end

  alias Dashboard.Sales.ProjectRebel

  @doc """
  Returns the list of project_rebels.

  ## Examples

      iex> list_project_rebels()
      [%ProjectRebel{}, ...]

  """
  def list_project_rebels do
    Repo.all(ProjectRebel)
  end

  @doc """
  Gets a single project_rebel.

  Raises `Ecto.NoResultsError` if the Project rebel does not exist.

  ## Examples

      iex> get_project_rebel!(123)
      %ProjectRebel{}

      iex> get_project_rebel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project_rebel!(id), do: Repo.get!(ProjectRebel, id)

  @doc """
  Creates a project_rebel.

  ## Examples

      iex> create_project_rebel(%{field: value})
      {:ok, %ProjectRebel{}}

      iex> create_project_rebel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project_rebel(attrs \\ %{}) do
    %ProjectRebel{}
    |> ProjectRebel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project_rebel.

  ## Examples

      iex> update_project_rebel(project_rebel, %{field: new_value})
      {:ok, %ProjectRebel{}}

      iex> update_project_rebel(project_rebel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project_rebel(%ProjectRebel{} = project_rebel, attrs) do
    project_rebel
    |> ProjectRebel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project_rebel.

  ## Examples

      iex> delete_project_rebel(project_rebel)
      {:ok, %ProjectRebel{}}

      iex> delete_project_rebel(project_rebel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project_rebel(%ProjectRebel{} = project_rebel) do
    Repo.delete(project_rebel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project_rebel changes.

  ## Examples

      iex> change_project_rebel(project_rebel)
      %Ecto.Changeset{data: %ProjectRebel{}}

  """
  def change_project_rebel(%ProjectRebel{} = project_rebel, attrs \\ %{}) do
    ProjectRebel.changeset(project_rebel, attrs)
  end

  alias Dashboard.Sales.PerformanceRequirement

  @doc """
  Returns the list of requirements.

  ## Examples

      iex> list_requirements()
      [%PerformanceRequirement{}, ...]

  """
  def list_requirements do
    Repo.all(PerformanceRequirement)
  end

  @doc """
  Gets a single performance_requirement.

  Raises `Ecto.NoResultsError` if the Performance requirement does not exist.

  ## Examples

      iex> get_performance_requirement!(123)
      %PerformanceRequirement{}

      iex> get_performance_requirement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_performance_requirement!(id), do: Repo.get!(PerformanceRequirement, id)

  @doc """
  Creates a performance_requirement.

  ## Examples

      iex> create_performance_requirement(%{field: value})
      {:ok, %PerformanceRequirement{}}

      iex> create_performance_requirement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_performance_requirement(attrs \\ %{}) do
    %PerformanceRequirement{}
    |> PerformanceRequirement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a performance_requirement.

  ## Examples

      iex> update_performance_requirement(performance_requirement, %{field: new_value})
      {:ok, %PerformanceRequirement{}}

      iex> update_performance_requirement(performance_requirement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_performance_requirement(%PerformanceRequirement{} = performance_requirement, attrs) do
    performance_requirement
    |> PerformanceRequirement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a performance_requirement.

  ## Examples

      iex> delete_performance_requirement(performance_requirement)
      {:ok, %PerformanceRequirement{}}

      iex> delete_performance_requirement(performance_requirement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_performance_requirement(%PerformanceRequirement{} = performance_requirement) do
    Repo.delete(performance_requirement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking performance_requirement changes.

  ## Examples

      iex> change_performance_requirement(performance_requirement)
      %Ecto.Changeset{data: %PerformanceRequirement{}}

  """
  def change_performance_requirement(%PerformanceRequirement{} = performance_requirement, attrs \\ %{}) do
    PerformanceRequirement.changeset(performance_requirement, attrs)
  end

  def add_rebel_to_project(%Rebel{} = rebel, %Project{} = project) do
    rebel
    |> Rebel.changeset_add_projects([project | rebel.projects])
    |> Repo.update
  end

  def add_rebel_to_project(%Project{} = project, %Rebel{} = rebel) do
    project
    |> Project.changeset_add_rebels([rebel | project.rebels])
    |> Repo.update
  end
end
