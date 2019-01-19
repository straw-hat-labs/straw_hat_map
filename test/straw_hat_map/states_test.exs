defmodule StrawHat.Map.StatesTest do
  use StrawHat.Map.Tests.CaseTemplate, async: true
  alias StrawHat.Map.States

  describe "find_state/1" do
    test "with valid id should returns the found state" do
      state = insert(:state)

      assert {:ok, _state} = States.find_state(Repo, state.id)
    end

    test "with invalid id shouldn't return any state" do
      state_id = Ecto.UUID.generate()
      assert {:error, _reason} = States.find_state(Repo, state_id)
    end
  end

  test "get_states/1 returns a pagination of states" do
    insert_list(10, :state)
    state_page = States.get_states(Repo, %{page: 2, page_size: 5})

    assert state_page.total_entries == 10
  end

  test "create_state/1 with valid inputs creates an state" do
    country = insert(:country)
    params = params_for(:state, %{country_id: country.id})

    assert {:ok, _state} = States.create_state(Repo, params)
    assert {:error, _state} = States.create_state(Repo, params)
  end

  test "update_state/2 with valid inputs updates the state" do
    state = insert(:state)
    {:ok, state} = States.update_state(Repo, state, %{name: "Havana"})

    assert state.name == "Havana"
  end

  test "destroy_state/1 with a found state destroys the state" do
    state = insert(:state)

    assert {:ok, _} = States.destroy_state(Repo, state)
  end

  test "get_states_by_ids/1 with a list of IDs returns the relative states" do
    available_states = insert_list(3, :state)

    ids =
      available_states
      |> Enum.take(2)
      |> Enum.map(fn state -> state.id end)

    states = States.get_states_by_ids(Repo, ids)

    assert List.first(states).id == List.first(ids)
    assert List.last(states).id == List.last(ids)
  end

  test "get_cities/1 returns the list of cities from the state" do
    state = insert(:state)
    insert_list(3, :city, %{state: state})
    cities = States.get_cities(Repo, state)

    assert length(cities) == 3
  end

  test "get_cities/1 returns the list of cities from a list of state IDs" do
    states = insert_list(2, :state)

    insert_list(2, :city, %{state: List.first(states)})
    insert_list(2, :city, %{state: List.last(states)})

    ids = Enum.map(states, fn state -> state.id end)
    cities = States.get_cities(Repo, ids)

    assert length(cities) == 4
  end

  test "get_counties/1 returns the list of counties from a list of state IDs" do
    states = insert_list(2, :state)

    insert_list(2, :county, %{state: List.first(states)})
    insert_list(2, :county, %{state: List.last(states)})

    ids = Enum.map(states, fn state -> state.id end)
    counties = States.get_counties(Repo, ids)

    assert length(counties) == 4
  end
end
