defmodule UrlShorten.Shortener do
  @moduledoc """
  The Shortener context.
  """

  import Ecto.Query, warn: false
  alias UrlShorten.Repo

  alias UrlShorten.Shortener.Slug

  @doc "Tests that a URL meets our validation requirements for slug generation."
  @spec is_valid_url(String.t) :: boolean
  def is_valid_url(url) do
      case URI.parse(url) do
        %URI{scheme: "http"} -> true

        %URI{scheme: "https"} -> true

        _ -> false
      end
  end

  @doc "Retrieves the URL for the given slug. Returns nil if it doesn't exist."
  @spec get_url_for_slug(String.t) :: String.t | nil
  def get_url_for_slug(slug) do
    case Repo.one(from s in Slug, where: s.slug == ^slug) do
      nil -> nil
      slug -> slug.url
    end
  end

  @doc """
  Creates a new slug record for the given URL.

  Slugs and URLs are unique in the DB, so this is actually an upsert.
  """
  @spec create_slug_for_url(String.t) :: {:ok, Slug.t} | {:error, String.t}
  def create_slug_for_url(url) do
    case is_valid_url(url) do
      false -> {:error, "Invalid URL (only 'http(s)://' URLs are allowed)"}
      true ->
        slug = %Slug{url: url, slug: generate_slug(url)}
        Repo.insert(slug, on_conflict: :nothing)
    end
  end

  @doc """
  Generates a slug string for a given URL.

  This is naively thrown together based on examples I've seen and may not be adequate at scale.
  """
  @spec generate_slug(String.t) :: String.t
  def generate_slug(url) do
    url
    |> sha256
    |> :binary.decode_unsigned
    |> int_to_bin32
    |> Base.url_encode64
    |> String.replace("==", "")
  end

  defp sha256(str) do
    :crypto.hash(:sha256, str)
  end

  defp int_to_bin32(int) do
    << int :: 32 >>
  end

  @doc """
  Returns the list of slugs.

  ## Examples

      iex> list_slugs()
      [%Slug{}, ...]

  """
  def list_slugs do
    Repo.all(Slug)
  end

  @doc """
  Gets a single slug.

  Raises `Ecto.NoResultsError` if the Slug does not exist.

  ## Examples

      iex> get_slug!(123)
      %Slug{}

      iex> get_slug!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slug!(id), do: Repo.get!(Slug, id)

  @doc """
  Creates a slug.

  ## Examples

      iex> create_slug(%{field: value})
      {:ok, %Slug{}}

      iex> create_slug(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slug(attrs \\ %{}) do
    %Slug{}
    |> Slug.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a slug.

  ## Examples

      iex> update_slug(slug, %{field: new_value})
      {:ok, %Slug{}}

      iex> update_slug(slug, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slug(%Slug{} = slug, attrs) do
    slug
    |> Slug.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a slug.

  ## Examples

      iex> delete_slug(slug)
      {:ok, %Slug{}}

      iex> delete_slug(slug)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slug(%Slug{} = slug) do
    Repo.delete(slug)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slug changes.

  ## Examples

      iex> change_slug(slug)
      %Ecto.Changeset{data: %Slug{}}

  """
  def change_slug(%Slug{} = slug, attrs \\ %{}) do
    Slug.changeset(slug, attrs)
  end
end
