defmodule Dashboard.Entities.Rebel do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Sales.{ProjectRebel, Session}
  alias Dashboard.Entities.{Project, Lead}
  alias Dashboard.Metrics.RebelWorkQuota
  alias Dashboard.Accounts.User

  schema "rebels" do
    field :first_name, :string
    field :last_name, :string

    has_many :leads, Lead
    has_many :sessions, Session
    has_many :work_quotas, RebelWorkQuota

    many_to_many :projects, Project, join_through: ProjectRebel

    has_one :user, User

    timestamps()
  end

  @required_fields [:first_name, :last_name]

  @doc false
  def changeset_add_projects(rebel, projects) do
    rebel
    |> cast(%{}, @required_fields)
    |> put_assoc(:projects, projects)
  end

  @doc false
  def changeset(rebel, attrs) do
    rebel
    |> cast(attrs, @required_fields)
    |> cast_assoc(:user)
    |> validate_required(@required_fields)
  end

  @doc false
  def register_changeset(rebel, attrs) do
    rebel
    |> cast(attrs, @required_fields)
    |> cast_assoc(:user, with: &User.register_changeset/2)
    |> validate_required(@required_fields)
  end

  def format_name(%__MODULE__{} = rebel) do
    ~s"#{rebel.first_name} #{rebel.last_name}"
  end
end
