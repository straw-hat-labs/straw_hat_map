defmodule StrawHat.Map.Migrations.AddPostalCodeRuleToCountries do
  @moduledoc false

  use Ecto.Migration

  @id ~N[2018-03-22 21:10:17]

  def change do
    alter table(:countries) do
      add(:postal_code_rule, :string)
    end
  end
end
