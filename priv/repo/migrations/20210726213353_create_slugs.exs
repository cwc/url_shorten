defmodule UrlShorten.Repo.Migrations.CreateSlugs do
  use Ecto.Migration

  def change do
    create table(:slugs) do
      add :slug, :string
      add :url, :string

      timestamps()
    end

    create unique_index(:slugs, [:slug, :url])
  end
end
