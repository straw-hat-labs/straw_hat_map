defmodule StrawHatMapTest.StateTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.State

  test "get state by id" do
    state = insert(:state)

    assert {:ok, _state} = State.find_state(state.id)
  end

  test "get state by invalid id" do
    assert {:error, _reason} = State.find_state(8745)
  end

  test "list of states" do
    insert_list(10, :state)
    state_page = State.get_states(%{page: 2, page_size: 5})

    assert state_page.total_entries == 10
  end

  describe "create state" do
    test "valid case" do
      country = insert(:country)
      params = params_for(:state, %{country_id: country.id})

      assert {:ok, _state} = State.create_state(params)
      assert {:error, _state} = State.create_state(params)
    end
  end

  test "update state" do
    state = insert(:state)
    {:ok, state} = State.update_state(state, %{"name": "Havana"})

    assert state.name == "Havana"
  end

  test "delete state" do
    state = insert(:state)

    assert {:ok, _} = State.destroy_state(state)
  end

  test "list of states by ids" do
    available_states = insert_list(3, :state)
    ids =
      available_states
      |> Enum.take(2)
      |> Enum.map(fn state -> state.id end)
    states = State.get_states_by_ids(ids)

    assert List.first(states).id == List.first(ids)
    assert List.last(states).id == List.last(ids)
  end

  test "list of states by country ids" do
    countries = insert_list(2, :country)

    insert_list(2, :state, %{country: List.first(countries)})
    insert_list(2, :state, %{country: List.last(countries)})

    ids =
      countries
      |> Enum.map(fn country -> country.id end)

    states = State.get_states_by_countries(ids)

    assert length(states) ==  4
  end

  test "list of cities" do
    state = insert(:state)
    insert_list(3, :city, %{state: state})
    cities = State.get_cities(state)

    assert length(cities) ==  3
  end
end
