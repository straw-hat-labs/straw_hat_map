defmodule StrawHat.Map.StatesTests do
  use StrawHat.Map.TestSupport.CaseTemplate, async: true
  alias StrawHat.Map.States

  describe "finding a state" do
    test "with a valid ID" do
      state = insert(:state)

      assert {:ok, _state} = States.find_state(Repo, state.id)
    end

    test "with an invalid ID" do
      state_id = Ecto.UUID.generate()

      assert {:error, _reason} = States.find_state(Repo, state_id)
    end
  end

  test "returning a pagination of states" do
    insert_list(6, :state)
    state_page = States.get_states(Repo, %{page: 2, page_size: 5})

    assert length(state_page.entries) == 1
  end

  test "creating a state with valid inputs" do
    country = insert(:country)
    params = params_for(:state, %{country_id: country.id})

    assert {:ok, _state} = States.create_state(Repo, params)
    assert {:error, _state} = States.create_state(Repo, params)
  end

  test "updating a state with valid inputs" do
    state = insert(:state)
    {:ok, state} = States.update_state(Repo, state, %{name: "Havana"})

    assert state.name == "Havana"
  end

  test "destroying an existing state" do
    state = insert(:state)

    assert {:ok, _} = States.destroy_state(Repo, state)
  end

  test "getting a list of states with a list of state's IDs" do
    states_ids =
      3
      |> insert_list(:state)
      |> Enum.map(&Map.get(&1, :id))

    found_states_ids =
      Repo
      |> States.get_states_by_ids(states_ids)
      |> Enum.map(&Map.get(&1, :id))

    assert states_ids == found_states_ids
  end

  test "getting a list of cities of a state" do
    state = insert(:state)

    cities_ids =
      3
      |> insert_list(:city, %{state: state})
      |> Enum.map(&Map.get(&1, :id))

    found_cities_ids =
      Repo
      |> States.get_cities(state)
      |> Enum.map(&Map.get(&1, :id))

    assert cities_ids == found_cities_ids
  end

  test "getting a list of cities with a list of state's IDs" do
    [first_state, second_state] = insert_list(2, :state)
    insert_list(2, :city, %{state: first_state})
    insert_list(2, :city, %{state: second_state})
    cities = States.get_cities(Repo, [first_state.id, second_state.id])

    assert length(cities) == 4
  end

  test "getting a list of counties with a list of state's IDs" do
    [first_state, second_state] = insert_list(2, :state)
    insert_list(2, :county, %{state: first_state})
    insert_list(2, :county, %{state: second_state})
    counties = States.get_counties(Repo, [first_state.id, second_state.id])

    assert length(counties) == 4
  end
end
