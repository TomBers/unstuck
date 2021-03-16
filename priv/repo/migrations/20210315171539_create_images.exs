defmodule Unstuck.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url, :string
      add :activity_id, references(:activities, on_delete: :nothing)

      timestamps()
    end

    create index(:images, [:activity_id])
  end
end
