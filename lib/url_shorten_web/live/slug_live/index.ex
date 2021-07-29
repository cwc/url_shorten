defmodule UrlShortenWeb.SlugLive.Index do
  use UrlShortenWeb, :live_view

  alias UrlShorten.Shortener
  alias UrlShorten.Shortener.Slug

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :slugs, list_slugs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Slug")
    |> assign(:slug, Shortener.get_slug!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Slug")
    |> assign(:slug, %Slug{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Slugs")
    |> assign(:slug, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    slug = Shortener.get_slug!(id)
    {:ok, _} = Shortener.delete_slug(slug)

    {:noreply, assign(socket, :slugs, list_slugs())}
  end

  defp list_slugs do
    Shortener.list_slugs()
  end
end
