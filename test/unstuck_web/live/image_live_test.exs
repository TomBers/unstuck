defmodule UnstuckWeb.ImageLiveTest do
  use UnstuckWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Unstuck.Progress

  @create_attrs %{url: "some url"}
  @update_attrs %{url: "some updated url"}
  @invalid_attrs %{url: nil}

  defp fixture(:image) do
    {:ok, image} = Progress.create_image(@create_attrs)
    image
  end

  defp create_image(_) do
    image = fixture(:image)
    %{image: image}
  end

  describe "Index" do
    setup [:create_image]

    test "lists all images", %{conn: conn, image: image} do
      {:ok, _index_live, html} = live(conn, Routes.image_index_path(conn, :index))

      assert html =~ "Listing Images"
      assert html =~ image.url
    end

    test "saves new image", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.image_index_path(conn, :index))

      assert index_live |> element("a", "New Image") |> render_click() =~
               "New Image"

      assert_patch(index_live, Routes.image_index_path(conn, :new))

      assert index_live
             |> form("#image-form", image: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#image-form", image: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.image_index_path(conn, :index))

      assert html =~ "Image created successfully"
      assert html =~ "some url"
    end

    test "updates image in listing", %{conn: conn, image: image} do
      {:ok, index_live, _html} = live(conn, Routes.image_index_path(conn, :index))

      assert index_live |> element("#image-#{image.id} a", "Edit") |> render_click() =~
               "Edit Image"

      assert_patch(index_live, Routes.image_index_path(conn, :edit, image))

      assert index_live
             |> form("#image-form", image: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#image-form", image: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.image_index_path(conn, :index))

      assert html =~ "Image updated successfully"
      assert html =~ "some updated url"
    end

    test "deletes image in listing", %{conn: conn, image: image} do
      {:ok, index_live, _html} = live(conn, Routes.image_index_path(conn, :index))

      assert index_live |> element("#image-#{image.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#image-#{image.id}")
    end
  end

  describe "Show" do
    setup [:create_image]

    test "displays image", %{conn: conn, image: image} do
      {:ok, _show_live, html} = live(conn, Routes.image_show_path(conn, :show, image))

      assert html =~ "Show Image"
      assert html =~ image.url
    end

    test "updates image within modal", %{conn: conn, image: image} do
      {:ok, show_live, _html} = live(conn, Routes.image_show_path(conn, :show, image))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Image"

      assert_patch(show_live, Routes.image_show_path(conn, :edit, image))

      assert show_live
             |> form("#image-form", image: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#image-form", image: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.image_show_path(conn, :show, image))

      assert html =~ "Image updated successfully"
      assert html =~ "some updated url"
    end
  end
end
