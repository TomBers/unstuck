defmodule UnstuckWeb.PageLive do
  use UnstuckWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, file_data: %{id: nil, url: nil})}
  end

  def handle_event("phx-dropzone", [_event, %{"id" => id, "name" => name}], socket) do
    res = %{id: id, url: "/images/upload"}
    {:noreply, assign(socket, file_data: res) }
  end


end
