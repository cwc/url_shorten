defmodule UrlShortenWeb.RedirectController do
  use UrlShortenWeb, :controller

  def redirect_slug(conn, %{"slug" => slug}) do
    case UrlShorten.Shortener.get_url_for_slug(slug) do
      nil -> put_flash(conn, :error, "Invalid slug") |> redirect(to: "/")
      url -> redirect(conn, external: url)
    end
  end
end
