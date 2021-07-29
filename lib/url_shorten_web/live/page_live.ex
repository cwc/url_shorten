defmodule UrlShortenWeb.PageLive do
  @moduledoc """
  The only page in this example, PageLive manages the UI for inputting a URL to shorten, and displaying the last shortened URL.
  """

  use UrlShortenWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, url: "", short_url: nil)}
  end

  @impl true
  def handle_event("shorten", %{"url" => url}, socket) do
    case UrlShorten.Shortener.create_slug_for_url(url) do
      {:error, err} ->
        {:noreply,
          socket
          |> put_flash(:error, err)}

      {:ok, slug} ->
        {:noreply,
         socket
         |> assign(short_url: "/" <> slug.slug, url: "") |> IO.inspect}
    end
  end
end
