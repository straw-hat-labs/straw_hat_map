defmodule StrawHat.Map.Repo.Migrations.AddPostalCodeRuleToCountries do
  use Ecto.Migration

  def change do
    alter table(:countries) do
      add(:postal_code_rule, :string)
    end
  end
end
