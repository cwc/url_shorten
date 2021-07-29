defmodule UrlShorten.ShortenerTest do
  use UrlShorten.DataCase

  alias UrlShorten.Shortener

  describe "slugs" do
    alias UrlShorten.Shortener.Slug

    @valid_attrs %{slug: "some slug", url: "some url"}
    @update_attrs %{slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{slug: nil, url: nil}

    def slug_fixture(attrs \\ %{}) do
      {:ok, slug} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shortener.create_slug()

      slug
    end

    test "list_slugs/0 returns all slugs" do
      slug = slug_fixture()
      assert Shortener.list_slugs() == [slug]
    end

    test "get_slug!/1 returns the slug with given id" do
      slug = slug_fixture()
      assert Shortener.get_slug!(slug.id) == slug
    end

    test "create_slug/1 with valid data creates a slug" do
      assert {:ok, %Slug{} = slug} = Shortener.create_slug(@valid_attrs)
      assert slug.slug == "some slug"
      assert slug.url == "some url"
    end

    test "create_slug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_slug(@invalid_attrs)
    end

    test "update_slug/2 with valid data updates the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{} = slug} = Shortener.update_slug(slug, @update_attrs)
      assert slug.slug == "some updated slug"
      assert slug.url == "some updated url"
    end

    test "update_slug/2 with invalid data returns error changeset" do
      slug = slug_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_slug(slug, @invalid_attrs)
      assert slug == Shortener.get_slug!(slug.id)
    end

    test "delete_slug/1 deletes the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{}} = Shortener.delete_slug(slug)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_slug!(slug.id) end
    end

    test "change_slug/1 returns a slug changeset" do
      slug = slug_fixture()
      assert %Ecto.Changeset{} = Shortener.change_slug(slug)
    end
  end
end
