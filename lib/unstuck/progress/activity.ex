defmodule Unstuck.Progress.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :completed_at, :date
    field :url, :string
    field :user_id, :id
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:url, :completed_at])
    |> validate_required([:url, :completed_at])
  end
end
