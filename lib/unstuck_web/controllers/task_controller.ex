defmodule UnstuckWeb.TaskController do
  use UnstuckWeb, :controller

  alias Unstuck.Ideas
  alias Unstuck.Ideas.Task

  def index(conn, _params) do
    tasks = Ideas.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Ideas.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def upload(conn, params) do
    IO.inspect(conn)
    IO.inspect(params)
    render(conn, "empty.html")
  end

  def create(conn, %{"task" => task_params}) do
    case Ideas.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Ideas.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Ideas.get_task!(id)
    changeset = Ideas.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Ideas.get_task!(id)

    case Ideas.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Ideas.get_task!(id)
    {:ok, _task} = Ideas.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end