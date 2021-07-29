defmodule UrlShortenWeb.SlugLive.Show do
  use UrlShortenWeb, :live_view

  alias UrlShorten.Shortener

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:slug, Shortener.get_slug!(id))}
  end

  defp page_title(:show), do: "Show Slug"
  defp page_title(:edit), do: "Edit Slug"
end
