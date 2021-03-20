defmodule Unstuck.Ideas.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias Unstuck.Progress.Activity

  schema "tasks" do
    field :name, :string
    field :level, :integer

    has_many :activities, Activity, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
