defmodule UnstuckWeb.ActivityLive.Show do
  use UnstuckWeb, :live_view

  alias Unstuck.Progress

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    activity = Progress.get_activity!(id)
    IO.inspect(activity)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:activity, activity)}
  end

  defp page_title(:show), do: "Show Activity"
  defp page_title(:edit), do: "Edit Activity"
end
