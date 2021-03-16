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
  def changeset(image, attrs, activity) do
    image
    |> cast(attrs, [:url])
    |> put_assoc(:activity, activity)
    |> validate_required([:url])
  end

  def changeset(image, attrs) do
    image
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
