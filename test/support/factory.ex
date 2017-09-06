defmodule StrawHatMapTest.Factory do
  use ExMachina.Ecto, repo: StrawHat.Map.Repo

  alias StrawHat.Map.Schema.{
    Country, State, County, City, Address, Place, Location}
  alias StrawHat.Map.Continent

  def base64(length \\ 8) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    |> binary_part(0, length)
  end

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
      name: base64(10),
      iso_two: base64(2),
      iso_three: base64(3),
      iso_numeric: iso_numeric,
      has_counties: true,
      continent: continent}
  end

  def state_factory do
    %State{
      code: base64(4),
      name: base64(8),
      country: build(:country)}
  end

  def county_factory do
    %County{
      name: base64(8),
      state: build(:state)}
  end

  def city_factory do
    %City{
      name: base64(8),
      state: build(:state)}
  end

  def address_factory do
    %Address{
      line_one: base64(4),
      line_two: base64(8),
      postal_code: "12345",
      city: build(:city)}
  end

  def location_factory do
    %Location{
      longitude: 22.34,
      latitude: 78.45,
      address: build(:address)}
  end

  def place_factory do
    %Place{
      name: base64(4),
      active: true,
      owner_id:  "1",
      location: build(:location)}
  end
end
