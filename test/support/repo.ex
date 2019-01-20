defmodule StrawHat.Map.TestSupport.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :straw_hat_map,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 25
end
