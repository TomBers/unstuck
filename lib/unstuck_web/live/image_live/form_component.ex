defmodule UnstuckWeb.ImageLive.FormComponent do
  use UnstuckWeb, :live_component

  alias Unstuck.Progress
  alias Unstuck.Progress.Image

  @impl true
  def mount(socket) do
    {:ok, allow_upload(socket, :images, accept: ~w(.png .jpg .jpeg), max_entries: 2)}
  end

  @impl true
  def update(%{image: image} = assigns, socket) do
    changeset = Progress.change_image(image)

    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
    }
  end

  @impl true
  def handle_event("validate", %{"image" => image_params}, socket) do
    changeset =
      socket.assigns.image
      |> Progress.change_image(image_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event(
        "save",
        %{
          "image" => %{
            "activity_id" => activity_id
          }
        },
        socket
      ) do
    activity = Progress.get_activity!(activity_id)
    save_image(socket, activity)
  end

  #  defp save_image(socket, :edit, image_params) do
  #
  #    case Progress.update_image(socket.assigns.image, image_params) do
  #      {:ok, _image} ->
  #        {:noreply,
  #         socket
  #         |> put_flash(:info, "Image updated successfully")
  #         |> push_redirect(to: socket.assigns.return_to)}
  #
  #      {:error, %Ecto.Changeset{} = changeset} ->
  #        {:noreply, assign(socket, :changeset, changeset)}
  #    end
  #  end

  defp save_image(socket, activity) do
    process_images(socket, activity)
    {
      :noreply,
      socket
      |> put_flash(:info, "Image created successfully")
      |> push_redirect(to: socket.assigns.return_to)
    }
  end

  def process_images(socket, activity) do
    {completed, []} = uploaded_entries(socket, :images)
    completed
    |> Enum.map(fn (img) -> save_and_store_img(socket, img, activity) end)

    consume_images(socket)
  end

  def save_and_store_img(socket, img, activity) do
    url = Routes.static_path(socket, "/images/#{img.uuid}.#{ext(img)}")
    image = %Image{url: url}
    Progress.create_image(image, %{}, activity)
  end

  defp ext(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    ext
  end

  defp put_image_url(socket, %Image{} = image) do
    {completed, []} = uploaded_entries(socket, :images)

    urls =
      for entry <- completed do
        Routes.static_path(socket, "/images/#{entry.uuid}.#{ext(entry)}")
      end

    url = Enum.at(urls, 0)

    %Image{image | url: url}
  end

  def consume_images(socket) do
    consume_uploaded_entries(
      socket,
      :images,
      fn meta, entry ->
        dest = Path.join("priv/static/images", "#{entry.uuid}.#{ext(entry)}")
        File.cp!(meta.path, dest)
      end
    )

    :ok
  end

end
