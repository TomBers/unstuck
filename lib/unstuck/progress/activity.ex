defmodule Unstuck.Progress.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  alias Unstuck.Progress.Image
  alias Unstuck.Ideas.Task
  alias Unstuck.Accounts.User

  schema "activities" do
    field :completed_at, :date

    belongs_to :user, User
    belongs_to :task, Task
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
