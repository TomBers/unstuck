defmodule UnstuckWeb.ImageLive.Index do
  use UnstuckWeb, :live_view

  alias Unstuck.Accounts
  alias Unstuck.Progress
  alias Unstuck.Progress.Image

  @impl true
  def mount(%{"id" => activity_id}, %{"user_token" => user_token}, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    tasks = Accounts.my_tasks(user)
    socket =
      socket
      |> assign(:activity, activity_id)
      |> assign(:tasks, tasks)
      |> assign(:user, user)

    {:ok, socket}
  end

  def mount(_params, %{"user_token" => user_token}, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    tasks = Accounts.my_tasks(user)
    socket =
      socket
      |> assign(:tasks, tasks)
      |> assign(:user, user)
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Image")
    |> assign(:image, Progress.get_image!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "")
    |> assign(:image, %Image{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Add progress")
    |> assign(:image, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    image = Progress.get_image!(id)
    {:ok, _} = Progress.delete_image(image)

    tasks = Accounts.my_tasks(socket.assigns.user)

    {:noreply, assign(socket, :tasks, tasks)}
  end

  def show_task(socket, activity) do
    UnstuckWeb.TaskView.render("html/#{activity.task.name}.html")
  end

  def incomplete_tasks(tasks) do
    tasks
    |> Enum.filter(fn(t) -> is_nil(t.completed_at) end)
    |> length
  end

  def get_s3_path(filename) do
    "https://unstuck-image-store.s3-eu-west-1.amazonaws.com/uploads/#{filename}"
  end

end
