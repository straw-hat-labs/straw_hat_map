defmodule StrawHat.Map.StatesTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.States

  describe "get state by id" do
    test "with valid id" do
      state = insert(:state)

      assert {:ok, _state} = States.find_state(state.id)
    end

    test "with invalid id" do
      assert {:error, _reason} = States.find_state(8745)
    end
  end

  test "get list of states" do
    insert_list(10, :state)
    state_page = States.get_states(%{page: 2, page_size: 5})

    assert state_page.total_entries == 10
  end

  describe "create a state" do
    test "with valid case" do
      country = insert(:country)
      params = params_for(:state, %{country_id: country.id})

      assert {:ok, _state} = States.create_state(params)
      assert {:error, _state} = States.create_state(params)
    end
  end

  test "update a state" do
    state = insert(:state)
    {:ok, state} = States.update_state(state, %{name: "Havana"})

    assert state.name == "Havana"
  end

  test "destroy a state" do
    state = insert(:state)

    assert {:ok, _} = States.destroy_state(state)
  end

  test "list of states by ids" do
    available_states = insert_list(3, :state)

    ids =
      available_states
      |> Enum.take(2)
      |> Enum.map(fn state -> state.id end)

    states = States.get_states_by_ids(ids)

    assert List.first(states).id == List.first(ids)
    assert List.last(states).id == List.last(ids)
  end

  test "list of cities" do
    state = insert(:state)
    insert_list(3, :city, %{state: state})
    cities = States.get_cities(state)

    assert length(cities) == 3
  end

  test "list of cities by state ids" do
    states = insert_list(2, :state)

    insert_list(2, :city, %{state: List.first(states)})
    insert_list(2, :city, %{state: List.last(states)})

    ids = Enum.map(states, fn state -> state.id end)
    cities = States.get_cities(ids)

    assert length(cities) == 4
  end

  test "list of counties by state ids" do
    states = insert_list(2, :state)

    insert_list(2, :county, %{state: List.first(states)})
    insert_list(2, :county, %{state: List.last(states)})

    ids = Enum.map(states, fn state -> state.id end)
    counties = States.get_counties(ids)

    assert length(counties) == 4
  end
end
