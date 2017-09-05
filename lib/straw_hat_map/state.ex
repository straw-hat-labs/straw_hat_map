defmodule StrawHat.Map.State do
  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.{StateQuery, CityQuery}
  alias StrawHat.Map.Schema.{State, City}

  def get_states(pagination \\ []), do: Repo.paginate(State, pagination)

  def create_state(state_attrs) do
    %State{}
    |> State.changeset(state_attrs)
    |> Repo.insert()
  end

  def update_state(%State{} = state, state_attrs) do
    state
    |> State.changeset(state_attrs)
    |> Repo.update()
  end

  def destroy_state(%State{} = state), do: Repo.delete(state)

  def find_state(state_id) do
    case get_state(state_id) do
      nil ->
        error = Error.new("map.state.not_found", metadata: [state_id: state_id])
        {:error, error}
      state -> {:ok, state}
    end
  end

  def get_state(state_id), do: Repo.get(State, state_id)

  def get_states_by_ids(state_ids) do
    State
    |> StateQuery.by_ids(state_ids)
    |> Repo.all()
  end

  def get_states_by_countries(country_ids) do
    State
    |> StateQuery.by_countries(country_ids)
    |> Repo.all()
  end

  def get_cities(%State{} = state) do
    City
    |> CityQuery.by_state(state.id)
    |> Repo.all()
  end
end
