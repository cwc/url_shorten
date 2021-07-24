defmodule UrlShorten.Repo do
  use Ecto.Repo,
    otp_app: :url_shorten,
    adapter: Ecto.Adapters.Postgres
end
