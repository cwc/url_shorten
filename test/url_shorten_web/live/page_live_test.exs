defmodule UrlShortenWeb.PageLiveTest do
  use UrlShortenWeb.ConnCase

  import Phoenix.LiveViewTest

  test "short URL is linked after submit", %{conn: conn} do
    url = "http://google.com"
    slug = "_U5NpQ"

    {:ok, view, _} = live(conn, "/")

    assert view
    |> element("form")
    |> render_submit(%{url: url}) =~ "/go/" <> slug
  end

  test "invalid URL error is displayed", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    assert view
    |> element("form")
    |> render_submit(%{url: "invalid"}) =~ "Invalid URL"
  end
end
