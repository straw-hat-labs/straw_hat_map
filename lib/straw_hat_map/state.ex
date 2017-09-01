defmodule StrawHat.Map.State do
  alias StrawHat.Map.Query.State, as: StateQuery
  alias StrawHat.Error
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

  def destroy_state(%State{} = state), do: Repo.delete(state)

  def find_state(id) do
    case get_state(id) do
      nil -> {:error, Error.new("map.state.not_found", metadata: [id: id])}
      state -> {:ok, state}
    end
  end

  def get_state(id), do: Repo.get(State, id)

  def state_by_ids(state_ids) do
    State
    |> StateQuery.by_ids(state_ids)
    |> Repo.all()
  end

  def states_by_countries(ids) do
    State
    |> StateQuery.by_countries(ids)
    |> Repo.all()
  end
end
