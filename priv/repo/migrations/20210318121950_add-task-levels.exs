defmodule :"Elixir.Unstuck.Repo.Migrations.Add-task-levels" do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :level, :integer

    end
  end
end
