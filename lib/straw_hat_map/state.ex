defmodule StrawHat.Map.State do
  @moduledoc """
  Defines functionality for states management.
  """

  use StrawHat.Map.Interactor

  alias StrawHat.Map.Query.{CityQuery, StateQuery, CountyQuery}
  alias StrawHat.Map.Schema.{City, State, County}

  @doc """
  Get the list of states.
  """
  @spec get_states(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_states(pagination \\ []), do: Repo.paginate(State, pagination)

  @doc """
  Create a state.
  """
  @spec create_state(State.state_attrs()) :: {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def create_state(state_attrs) do
    %State{}
    |> State.changeset(state_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a state.
  """
  @spec update_state(State.t(), State.state_attrs()) ::
          {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def update_state(%State{} = state, state_attrs) do
    state
    |> State.changeset(state_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a state.
  """
  @spec destroy_state(State.t()) :: {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def destroy_state(%State{} = state), do: Repo.delete(state)

  @doc """
  Get a state by `id`.
  """
  @spec find_state(String.t()) :: {:ok, State.t()} | {:error, Error.t()}
  def find_state(state_id) do
    case get_state(state_id) do
      nil ->
        error = Error.new("straw_hat_map.state.not_found", metadata: [state_id: state_id])
        {:error, error}

      state ->
        {:ok, state}
    end
  end

  @doc """
  Get a state by `id`.
  """
  @spec get_state(String.t()) :: State.t() | nil | no_return
  def get_state(state_id), do: Repo.get(State, state_id)

  @doc """
  Get list of states.
  """
  @spec get_states_by_ids([integer()]) :: [State.t()] | no_return()
  def get_states_by_ids(state_ids) do
    State
    |> StateQuery.by_ids(state_ids)
    |> Repo.all()
  end

  @doc """
  Get list of cities.
  """
  @spec get_cities(State.t()) :: [City.t()] | no_return()
  def get_cities(%State{} = state) do
    City
    |> CityQuery.by_state(state.id)
    |> Repo.all()
  end

  @spec get_cities([integer()]) :: [City.t()] | no_return()
  def get_cities(state_ids) when is_list(state_ids) do
    City
    |> CityQuery.by_states(state_ids)
    |> Repo.all()
  end

  @doc """
  Get list of counties.
  """
  @spec get_counties([integer()]) :: [County.t()] | no_return()
  def get_counties(state_ids) when is_list(state_ids) do
    County
    |> CountyQuery.by_states(state_ids)
    |> Repo.all()
  end
end
