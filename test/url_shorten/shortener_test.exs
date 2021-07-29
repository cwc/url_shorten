defmodule UrlShorten.ShortenerTest do
  use UrlShorten.DataCase

  alias UrlShorten.Shortener

  describe "slugs" do
    alias UrlShorten.Shortener.Slug

    @valid_attrs %{slug: "slug", url: "http://google.com"}
    @update_attrs %{slug: "slug", url: "https://google.com"}
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
      assert slug.slug == "slug"
      assert slug.url == "http://google.com"
    end

    test "create_slug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_slug(@invalid_attrs)
    end

    test "update_slug/2 with valid data updates the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{} = slug} = Shortener.update_slug(slug, @update_attrs)
      assert slug.slug == "slug"
      assert slug.url == "https://google.com"
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

    test "is_valid_url/1 validates HTTP(S) URLs" do
      assert Shortener.is_valid_url("http://test")
      assert Shortener.is_valid_url("https://test")
      assert Shortener.is_valid_url("http://")
      assert Shortener.is_valid_url("https://")
    end

    test "is_valid_url/1 invalidates non-HTTP(S) URLs" do
      assert !Shortener.is_valid_url("ftp://test")
      assert !Shortener.is_valid_url("test")
    end

    test "get_url_for_slug/1 returns a slug's URL" do
      slug = slug_fixture()
      assert Shortener.get_url_for_slug(slug.slug) == slug.url
    end

    test "get_url_for_slug/1 returns nil for non-existent slugs" do
      assert Shortener.get_url_for_slug("not there") == nil
    end

    test "create_slug_for_url/1 creates a slug record for valid URLs" do
      {:ok, slug} = Shortener.create_slug_for_url("http://test")
      assert slug.url == "http://test"
      assert Shortener.get_url_for_slug(slug.slug) == "http://test"
    end

    test "create_slug_for_url/1 returns an error for invalid URLs" do
      {result, _} = Shortener.create_slug_for_url("invalid")
      assert result == :error
    end

    test "generate_slug/1 creates a known hash for a string" do
      # Not the most useful test, but would raise a flag if the algo changes unexpectedly
      assert Shortener.generate_slug("test") == "sPAKCA"
    end
  end
end
