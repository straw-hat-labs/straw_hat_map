defmodule StrawHat.Map.State do
  import Ecto.Query, only: [from: 2]

  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.State

  def list_states(params), do: Repo.paginate(State, params)

  def create_state(params) do
    %State{}
    |> State.changeset(params)
    |> Repo.insert()
  end

  def update_state(%State{} = state, params) do
    state
    |> State.changeset(params)
    |> Repo.update()
  end
  def update_state(id, params) do
    with {:ok, state} <- find_state(id),
      do: update_state(state, params)
  end

  def destroy_state(%State{} = state),
    do: Repo.delete(state)
  def destroy_state(id) do
    with {:ok, state} <- find_state(id),
      do: destroy_state(state)
  end

  def find_state(id) do
    case get_state(id) do
      nil -> {:error, {:not_found, "State #{id} not found"}}
      state -> {:ok, state}
    end
  end

  def get_state(id),
    do: Repo.get(State, id)

  def state_by_ids(state_ids) do
    query =
      from state in State,
      where: state.id in ^state_ids
    Repo.all(query)
  end

  def states_by_countries(ids) do
    query =
      from state in State,
      where: state.country_id in ^ids
    Repo.all(query)
  end
end
