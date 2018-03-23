defmodule StrawHat.Map.States do
  @moduledoc """
  Defines functionality for states management.
  """

  use StrawHat.Map.Interactor
  alias StrawHat.Map.{State, County, City}

  @doc """
  Gets the list of states.
  """
  @spec get_states(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_states(pagination \\ []), do: Repo.paginate(State, pagination)

  @doc """
  Creates a state.
  """
  @spec create_state(State.state_attrs()) :: {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def create_state(state_attrs) do
    %State{}
    |> State.changeset(state_attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a state.
  """
  @spec update_state(State.t(), State.state_attrs()) ::
          {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def update_state(%State{} = state, state_attrs) do
    state
    |> State.changeset(state_attrs)
    |> Repo.update()
  end

  @doc """
  Destroys a state.
  """
  @spec destroy_state(State.t()) :: {:ok, State.t()} | {:error, Ecto.Changeset.t()}
  def destroy_state(%State{} = state), do: Repo.delete(state)

  @doc """
  Gets a state by `id`.
  """
  @spec find_state(String.t()) :: {:ok, State.t()} | {:error, Error.t()}
  def find_state(state_id) do
    state_id
    |> get_state()
    |> StrawHat.Response.from_value(
      Error.new("straw_hat_map.state.not_found", metadata: [state_id: state_id])
    )
  end

  @doc """
  Gets a state by `id`.
  """
  @spec get_state(String.t()) :: State.t() | nil | no_return
  def get_state(state_id), do: Repo.get(State, state_id)

  @doc """
  Gets list of states.
  """
  @spec get_states_by_ids([integer()]) :: [State.t()] | no_return()
  def get_states_by_ids(state_ids) do
    query = from(state in State, where: state.id in ^state_ids)
    Repo.all(query)
  end

  @doc """
  Gets list of cities.
  """
  @spec get_cities(State.t()) :: [City.t()] | no_return()
  def get_cities(%State{} = state) do
    query = from(city in City, where: city.state_id == ^state.id)
    Repo.all(query)
  end

  @spec get_cities([integer()]) :: [City.t()] | no_return()
  def get_cities(state_ids) when is_list(state_ids) do
    query = from(city in City, where: city.state_id in ^state_ids)
    Repo.all(query)
  end

  @doc """
  Gets list of counties.
  """
  @spec get_counties([integer()]) :: [County.t()] | no_return()
  def get_counties(state_ids) when is_list(state_ids) do
    query = from(county in County, where: county.state_id in ^state_ids)
    Repo.all(query)
  end
end
