defmodule UnstuckWeb.PageLive do
  use UnstuckWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, file_data: %{id: nil, url: nil})}
  end

  def handle_event("phx-dropzone", [_event, _payload], socket) do
    IO.inspect(_event)
    IO.inspect(_payload)
    IO.inspect(socket.assigns)
    {:noreply, socket}
  end


end
