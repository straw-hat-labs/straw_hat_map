defmodule StrawHat.Map.Tests.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: StrawHat.Map.Repo

  alias StrawHat.Map.{Address, Country, Continents, County, City, Location, State}

  def country_factory do
    iso_numeric = "#{:rand.uniform(9)}#{:rand.uniform(9)}#{:rand.uniform(9)}"

    continent =
      Continents.get_continent_codes()
      |> Enum.shuffle()
      |> hd()

    %Country{
      name: Faker.String.base64(10),
      iso_two: Faker.format("??"),
      iso_three: Faker.format("???"),
      iso_numeric: iso_numeric,
      has_counties: true,
      continent: continent
    }
  end

  def state_factory do
    %State{code: Faker.String.base64(4), name: Faker.String.base64(8), country: build(:country)}
  end

  def county_factory do
    %County{name: Faker.String.base64(8), state: build(:state)}
  end

  def city_factory do
    capital? =
      [true, false]
      |> Enum.take_random(1)
      |> List.first()

    %City{name: Faker.String.base64(8), capital: capital?, state: build(:state)}
  end

  def address_factory do
    %Address{
      line_one: Faker.String.base64(4),
      line_two: Faker.String.base64(8),
      postal_code: "12345",
      city: build(:city)
    }
  end

  def location_factory do
    %Location{
      location: %Geo.Point{coordinates: {-83.550948, 22.3709423}},
      address: build(:address)
    }
  end
end
