defmodule Unstuck.Progress.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias Unstuck.Progress.Activity

  schema "images" do
    field :url, :string

    belongs_to :activity, Activity

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:url, :activity_id])
    |> validate_required([:url, :activity_id])
  end
end
