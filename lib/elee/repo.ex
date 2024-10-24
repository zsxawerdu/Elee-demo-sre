defmodule Elee.Repo do
  use Ecto.Repo,
    otp_app: :elee,
    adapter: Ecto.Adapters.SQLite3
end
