defmodule Toilet.Repo do
  use Ecto.Repo,
    otp_app: :disney_toilet,
    adapter: Ecto.Adapters.Postgres
end
