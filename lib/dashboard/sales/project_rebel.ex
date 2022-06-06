defmodule Dashboard.Sales.ProjectRebel do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dashboard.Entities.{Project, Rebel}

  schema "project_rebels" do
    belongs_to :project, Project
    belongs_to :rebel, Rebel

    timestamps()
  end

  @doc false
  def changeset(project_rebel, attrs) do
    project_rebel
    |> cast(attrs, [])
    |> validate_required([])
  end
end
