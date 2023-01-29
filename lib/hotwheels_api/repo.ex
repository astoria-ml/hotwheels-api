defmodule HotwheelsApi.Repo do
  use Ecto.Repo,
    otp_app: :hotwheels_api,
    adapter: Ecto.Adapters.Postgres
end
