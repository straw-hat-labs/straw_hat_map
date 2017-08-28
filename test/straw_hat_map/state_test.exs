defmodule StrawHatMapTest.StateTest do
  use StrawHatMapTest.DataCase, async: true
  alias StrawHat.Map.State

  test "get by id" do
    state = insert(:state)
    assert {:ok, _state} = State.find_state(state.id)
  end

  test "invalid id" do
    assert {:error, _reason} = State.find_state(8745)
  end

  test "list per page" do
    insert_list(10, :state)
    state = State.list_states(%{page: 2, page_size: 5})
    assert state.total_entries == 10
  end

  test "create" do
    country = insert(:country)
    params = %{code: "001", name: "Havana", country_id: country.id}
    assert {:ok, _state} = State.create_state(params)
  end

  test "update by entity" do
    state = insert(:state)
    {:ok, state} = State.update_state(state, %{"name": "Havana"})
    assert state.name == "Havana"
  end

  test "update by id" do
    state = insert(:state)
    {:ok, state} = State.update_state(state.id, %{"name": "Havana"})
    assert state.name == "Havana"
  end

  test "update by invalid id" do
    {:error, _} = State.update_state(99999, %{})
  end

  test "delete state by id" do
    state = insert(:state)
    assert {:ok, _} = State.destroy_state(state.id)
  end
end
