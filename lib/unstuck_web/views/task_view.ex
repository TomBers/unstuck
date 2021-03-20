defmodule UnstuckWeb.TaskView do
  use UnstuckWeb, :view

  def group_tasks(tasks) do
    Enum.group_by(tasks, fn(task) -> task.level end)
  end

end
