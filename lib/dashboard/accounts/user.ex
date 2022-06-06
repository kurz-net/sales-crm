defmodule Dashboard.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Dashboard.Repo
  alias Dashboard.Entities.{Rebel, Partner}
  alias Dashboard.Accounts.ActivationCode

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :role, :string
    field :code, :string

    belongs_to :rebel, Rebel
    belongs_to :partner, Partner

    timestamps()
  end

  @register_required_fields [:email, :password, :password_confirmation, :code]
  @register_optional_fields [:role, :rebel_id, :partner_id]

  @doc false
  def register_changeset(user, attrs) do
    user
    |> cast(attrs, @register_required_fields ++ @register_optional_fields)
    |> cast_assoc(:rebel, with: &Rebel.changeset/2)
    |> cast_assoc(:partner, with: &Partner.changeset/2)
    |> validate_required(@register_required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_password
    |> put_pass_hash
    |> validate_code
  end

  defp validate_code(changeset) do
    code = get_field(changeset, :code)

    if is_nil(code) do
      changeset
    else
      activation_code = Repo.get_by(ActivationCode, code: code)

      if is_nil(activation_code) do
        add_error(changeset, :code, "Nicht gültig!")
      else
        users = __MODULE__
                |> where([u], u.code == ^code)
                |> Repo.all

        if length(users) != 0 do
          add_error(changeset, :code, "Nicht gültig!")
        else
          changeset
        end
      end
    end
  end

  defp validate_password(changeset) do
    password = get_field(changeset, :password)
    confirm = get_field(changeset, :password_confirmation)

    if password != confirm do
      changeset
      |> add_error(:password, "Passwörter stimmen nicht überein")
      |> add_error(:password_confirmation, "Passwörter stimmen nicht überein")
    else
      changeset
    end
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :role])
    |> validate_required([:email, :password, :role])
  end

  @doc false
  def changeset_email(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
