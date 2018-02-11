defmodule StrawHat.Map.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Map.Repo

  alias StrawHat.Map.Schema.{Country, State, County, City, Address, Place, Location}
  alias StrawHat.Map.Continent

  def country_factory do
    iso_numeric =
      111..999
      |> Enum.random()
      |> to_string()

    continent =
      Continent.get_continent_codes()
      |> Enum.shuffle()
      |> hd()

    %Country{
      name: Faker.String.base64(10),
      iso_two: Faker.String.base64(2),
      iso_three: Faker.String.base64(3),
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
    %Location{longitude: 22.34, latitude: 78.45, address: build(:address)}
  end

  def place_factory do
    %Place{name: Faker.String.base64(4), owner_id: "1", location: build(:location)}
  end
end
