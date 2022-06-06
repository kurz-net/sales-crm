defmodule Dashboard.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Dashboard.Repo

  alias Dashboard.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.register_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Dashboard.Accounts.ActivationCode

  @doc """
  Returns the list of activation_codes.

  ## Examples

      iex> list_activation_codes()
      [%ActivationCode{}, ...]

  """
  def list_activation_codes do
    Repo.all(ActivationCode)
  end

  @doc """
  Gets a single activation_code.

  Raises `Ecto.NoResultsError` if the Activation code does not exist.

  ## Examples

      iex> get_activation_code!(123)
      %ActivationCode{}

      iex> get_activation_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activation_code!(id), do: Repo.get!(ActivationCode, id)

  @doc """
  Creates a activation_code.

  ## Examples

      iex> create_activation_code(%{field: value})
      {:ok, %ActivationCode{}}

      iex> create_activation_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activation_code(attrs \\ %{}) do
    %ActivationCode{}
    |> ActivationCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activation_code.

  ## Examples

      iex> update_activation_code(activation_code, %{field: new_value})
      {:ok, %ActivationCode{}}

      iex> update_activation_code(activation_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activation_code(%ActivationCode{} = activation_code, attrs) do
    activation_code
    |> ActivationCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activation_code.

  ## Examples

      iex> delete_activation_code(activation_code)
      {:ok, %ActivationCode{}}

      iex> delete_activation_code(activation_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activation_code(%ActivationCode{} = activation_code) do
    Repo.delete(activation_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activation_code changes.

  ## Examples

      iex> change_activation_code(activation_code)
      %Ecto.Changeset{data: %ActivationCode{}}

  """
  def change_activation_code(%ActivationCode{} = activation_code, attrs \\ %{}) do
    ActivationCode.changeset(activation_code, attrs)
  end

  def verify_user(%{email: email, password: password}) do
    Repo.get_by(User, email: email)
    |> Argon2.check_pass(password)
  end
end
