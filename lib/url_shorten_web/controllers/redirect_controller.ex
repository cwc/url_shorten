defmodule UrlShortenWeb.RedirectController do
  @moduledoc """
  This module handles requests to shortened URLs, redirecting them to their destination.
  """
  use UrlShortenWeb, :controller

  @doc "Redirects a slug to its destination URL."
  def redirect_slug(conn, %{"slug" => slug}) do
    case UrlShorten.Shortener.get_url_for_slug(slug) do
      nil -> put_flash(conn, :error, "Invalid slug") |> redirect(to: "/")
      url -> redirect(conn, external: url)
    end
  end
end
