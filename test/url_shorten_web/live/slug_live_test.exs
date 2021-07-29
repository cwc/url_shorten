defmodule UrlShortenWeb.SlugLiveTest do
  use UrlShortenWeb.ConnCase

  import Phoenix.LiveViewTest

  alias UrlShorten.Shortener

  @create_attrs %{slug: "some slug", url: "some url"}
  @update_attrs %{slug: "some updated slug", url: "some updated url"}
  @invalid_attrs %{slug: nil, url: nil}

  defp fixture(:slug) do
    {:ok, slug} = Shortener.create_slug(@create_attrs)
    slug
  end

  defp create_slug(_) do
    slug = fixture(:slug)
    %{slug: slug}
  end

  describe "Index" do
    setup [:create_slug]

    test "lists all slugs", %{conn: conn, slug: slug} do
      {:ok, _index_live, html} = live(conn, Routes.slug_index_path(conn, :index))

      assert html =~ "Listing Slugs"
      assert html =~ slug.slug
    end

    test "saves new slug", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.slug_index_path(conn, :index))

      assert index_live |> element("a", "New Slug") |> render_click() =~
               "New Slug"

      assert_patch(index_live, Routes.slug_index_path(conn, :new))

      assert index_live
             |> form("#slug-form", slug: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#slug-form", slug: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.slug_index_path(conn, :index))

      assert html =~ "Slug created successfully"
      assert html =~ "some slug"
    end

    test "updates slug in listing", %{conn: conn, slug: slug} do
      {:ok, index_live, _html} = live(conn, Routes.slug_index_path(conn, :index))

      assert index_live |> element("#slug-#{slug.id} a", "Edit") |> render_click() =~
               "Edit Slug"

      assert_patch(index_live, Routes.slug_index_path(conn, :edit, slug))

      assert index_live
             |> form("#slug-form", slug: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#slug-form", slug: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.slug_index_path(conn, :index))

      assert html =~ "Slug updated successfully"
      assert html =~ "some updated slug"
    end

    test "deletes slug in listing", %{conn: conn, slug: slug} do
      {:ok, index_live, _html} = live(conn, Routes.slug_index_path(conn, :index))

      assert index_live |> element("#slug-#{slug.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#slug-#{slug.id}")
    end
  end

  describe "Show" do
    setup [:create_slug]

    test "displays slug", %{conn: conn, slug: slug} do
      {:ok, _show_live, html} = live(conn, Routes.slug_show_path(conn, :show, slug))

      assert html =~ "Show Slug"
      assert html =~ slug.slug
    end

    test "updates slug within modal", %{conn: conn, slug: slug} do
      {:ok, show_live, _html} = live(conn, Routes.slug_show_path(conn, :show, slug))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Slug"

      assert_patch(show_live, Routes.slug_show_path(conn, :edit, slug))

      assert show_live
             |> form("#slug-form", slug: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#slug-form", slug: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.slug_show_path(conn, :show, slug))

      assert html =~ "Slug updated successfully"
      assert html =~ "some updated slug"
    end
  end
end
