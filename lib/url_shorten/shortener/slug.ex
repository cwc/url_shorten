defmodule UrlShorten.Shortener.Slug do
  use Ecto.Schema
  import Ecto.Changeset

  schema "slugs" do
    field :slug, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(slug, attrs) do
    slug
    |> cast(attrs, [:slug, :url])
    |> validate_required([:slug, :url])
    |> unique_constraint([:slug, :url])
    |> validate_url
  end

  @doc "Simple validator to make sure only valid URLs can be inserted into the DB."
  def validate_url(changeset) do
    validate_change(changeset, :url, fn field, value ->
      case UrlShorten.Shortener.is_valid_url(value) do
        true -> []
        false -> [{field, "Invalid URL"}]
      end
    end)
  end
end
