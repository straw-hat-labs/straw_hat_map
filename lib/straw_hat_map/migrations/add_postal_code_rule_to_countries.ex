defmodule StrawHat.Map.Migrations.AddPostalCodeRuleToCountries do
  @moduledoc """
  Add postal code rule column to countries table.

  Created at: ~N[2018-03-22 21:10:17]
  """

  use Ecto.Migration

  def change do
    alter table(:countries) do
      add(:postal_code_rule, :string)
    end
  end
end
