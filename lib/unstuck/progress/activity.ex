defmodule Unstuck.Progress.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  alias Unstuck.Progress.Image

  schema "activities" do
    field :completed_at, :date
    field :user_id, :id
    field :task_id, :id

    has_many :images, Image, on_delete: :delete_all


    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:user_id, :task_id, :completed_at])
    |> validate_required([:user_id, :task_id])
  end
end
