defmodule StrawHat.Map.Test.Factory do
  use ExMachina.Ecto, repo: StrawHat.Map.Repo

  alias StrawHat.Map.Schema.{Country, State, County, City, Address, Place}

  def get_random_string(length \\ 5) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode64
  end

  def country_factory do
    %Country{
      code: get_random_string(4),
      name: get_random_string(8)}
  end

  def state_factory do
    %State{
      code: get_random_string(4),
      name: get_random_string(8),
      country: build(:country)}
  end

  def county_factory do
    %County{
      code: get_random_string(4),
      name: get_random_string(8),
      state: build(:state)}
  end

  def city_factory do
    %City{
      code: get_random_string(4),
      name: get_random_string(8),
      county: build(:county)}
  end

  def address_factory do
    %Address{
      line_one: get_random_string(4),
      line_two: get_random_string(8),
      postal_code: "12345",
      city: build(:city)}
  end

  def place_factory do
    %Place{
      name: get_random_string(4),
      longitude: 22.34,
      latitude:  78.45,
      active: true,
      account_id:  1,
      address: build(:address)}
  end
end
