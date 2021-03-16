defmodule Unstuck.ProgressTest do
  use Unstuck.DataCase

  alias Unstuck.Progress

  describe "activities" do
    alias Unstuck.Progress.Activity

    @valid_attrs %{completed_at: ~D[2010-04-17], url: "some url"}
    @update_attrs %{completed_at: ~D[2011-05-18], url: "some updated url"}
    @invalid_attrs %{completed_at: nil, url: nil}

    def activity_fixture(attrs \\ %{}) do
      {:ok, activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Progress.create_activity()

      activity
    end

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert Progress.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Progress.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      assert {:ok, %Activity{} = activity} = Progress.create_activity(@valid_attrs)
      assert activity.completed_at == ~D[2010-04-17]
      assert activity.url == "some url"
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Progress.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{} = activity} = Progress.update_activity(activity, @update_attrs)
      assert activity.completed_at == ~D[2011-05-18]
      assert activity.url == "some updated url"
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Progress.update_activity(activity, @invalid_attrs)
      assert activity == Progress.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Progress.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Progress.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Progress.change_activity(activity)
    end
  end

  describe "images" do
    alias Unstuck.Progress.Image

    @valid_attrs %{url: "some url"}
    @update_attrs %{url: "some updated url"}
    @invalid_attrs %{url: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Progress.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Progress.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Progress.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Progress.create_image(@valid_attrs)
      assert image.url == "some url"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Progress.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Progress.update_image(image, @update_attrs)
      assert image.url == "some updated url"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Progress.update_image(image, @invalid_attrs)
      assert image == Progress.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Progress.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Progress.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Progress.change_image(image)
    end
  end
end
