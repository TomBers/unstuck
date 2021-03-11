defmodule Unstuck.Repo do
  use Ecto.Repo,
    otp_app: :unstuck,
    adapter: Ecto.Adapters.Postgres
end
