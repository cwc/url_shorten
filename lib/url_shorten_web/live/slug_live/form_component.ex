defmodule UrlShortenWeb.SlugLive.FormComponent do
  use UrlShortenWeb, :live_component

  alias UrlShorten.Shortener

  @impl true
  def update(%{slug: slug} = assigns, socket) do
    changeset = Shortener.change_slug(slug)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"slug" => slug_params}, socket) do
    changeset =
      socket.assigns.slug
      |> Shortener.change_slug(slug_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"slug" => slug_params}, socket) do
    save_slug(socket, socket.assigns.action, slug_params)
  end

  defp save_slug(socket, :edit, slug_params) do
    case Shortener.update_slug(socket.assigns.slug, slug_params) do
      {:ok, _slug} ->
        {:noreply,
         socket
         |> put_flash(:info, "Slug updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_slug(socket, :new, slug_params) do
    case Shortener.create_slug(slug_params) do
      {:ok, _slug} ->
        {:noreply,
         socket
         |> put_flash(:info, "Slug created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
