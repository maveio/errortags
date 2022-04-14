defmodule Errortags.Repo do
  use Ecto.Repo,
    otp_app: :errortags,
    adapter: Ecto.Adapters.Postgres
end
