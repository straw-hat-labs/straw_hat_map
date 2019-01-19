defmodule StrawHat.Map.Migrations.AddPostalCodeRuleToCountries do
  use Ecto.Migration

  @id 20180322211017

  def change do
    alter table(:countries) do
      add(:postal_code_rule, :string)
    end
  end
end
