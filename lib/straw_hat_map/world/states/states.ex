defmodule StrawHat.Map.States do
  @moduledoc """
  State management use cases.
  """

  import Ecto.Query, only: [from: 2]
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.Repo
  alias StrawHat.Map.{State, County, City}

  @spec get_states(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_states(pagination \\ []) do
    Repo.paginate(State, pagination)
  end

  @spec create_state(State.state_attrs()) :: Response.t(State.t(), Ecto.Changeset.t())
  def create_state(state_attrs) do
    %State{}
    |> State.changeset(state_attrs)
    |> Repo.insert()
    |> Response.from_value()
  end

  @spec update_state(State.t(), State.state_attrs()) :: Response.t(State.t(), Ecto.Changeset.t())
  def update_state(%State{} = state, state_attrs) do
    state
    |> State.changeset(state_attrs)
    |> Repo.update()
    |> Response.from_value()
  end

  @spec destroy_state(State.t()) :: Response.t(State.t(), Ecto.Changeset.t())
  def destroy_state(%State{} = state) do
    state
    |> Repo.delete()
    |> Response.from_value()
  end

  @spec find_state(String.t()) :: Response.t(State.t(), Error.t())
  def find_state(state_id) do
    state_id
    |> get_state()
    |> Response.from_value(
      Error.new("straw_hat_map.state.not_found", metadata: [state_id: state_id])
    )
  end

  @spec get_state(String.t()) :: State.t() | nil | no_return
  def get_state(state_id) do
    Repo.get(State, state_id)
  end

  @spec get_states_by_ids([integer()]) :: [State.t()] | no_return()
  def get_states_by_ids(state_ids) do
    query = from(state in State, where: state.id in ^state_ids)
    Repo.all(query)
  end

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

  @spec get_counties([integer()]) :: [County.t()] | no_return()
  def get_counties(state_ids) when is_list(state_ids) do
    query = from(county in County, where: county.state_id in ^state_ids)
    Repo.all(query)
  end
end
