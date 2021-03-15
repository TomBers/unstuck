defmodule Unstuck.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :url, :string
      add :completed_at, :date
      add :user_id, references(:users, on_delete: :nothing)
      add :task_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:activities, [:user_id])
    create index(:activities, [:task_id])
  end
end
