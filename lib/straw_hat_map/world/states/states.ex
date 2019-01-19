defmodule StrawHat.Map.States do
  @moduledoc """
  States management use cases.
  """

  import Ecto.Query, only: [from: 2]
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.{State, County, City}

  @spec get_states(Ecto.Repo.t(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_states(repo, pagination \\ []) do
    repo.paginate(State, pagination)
  end

  @spec create_state(Ecto.Repo.t(), State.state_attrs()) ::
          Response.t(State.t(), Ecto.Changeset.t())
  def create_state(repo, state_attrs) do
    %State{}
    |> State.changeset(state_attrs)
    |> repo.insert()
    |> Response.from_value()
  end

  @spec update_state(Ecto.Repo.t(), State.t(), State.state_attrs()) ::
          Response.t(State.t(), Ecto.Changeset.t())
  def update_state(repo, %State{} = state, state_attrs) do
    state
    |> State.changeset(state_attrs)
    |> repo.update()
    |> Response.from_value()
  end

  @spec destroy_state(Ecto.Repo.t(), State.t()) :: Response.t(State.t(), Ecto.Changeset.t())
  def destroy_state(repo, %State{} = state) do
    state
    |> repo.delete()
    |> Response.from_value()
  end

  @spec find_state(Ecto.Repo.t(), String.t()) :: Response.t(State.t(), Error.t())
  def find_state(repo, state_id) do
    repo
    |> get_state(state_id)
    |> Response.from_value(
      Error.new("straw_hat_map.state.not_found", metadata: [state_id: state_id])
    )
  end

  @spec get_state(Ecto.Repo.t(), String.t()) :: State.t() | nil | no_return
  def get_state(repo, state_id) do
    repo.get(State, state_id)
  end

  @spec get_states_by_ids(Ecto.Repo.t(), [integer()]) :: [State.t()] | no_return()
  def get_states_by_ids(repo, state_ids) do
    query = from(state in State, where: state.id in ^state_ids)
    repo.all(query)
  end

  @spec get_cities(Ecto.Repo.t(), State.t()) :: [City.t()] | no_return()
  def get_cities(repo, %State{} = state) do
    query = from(city in City, where: city.state_id == ^state.id)
    repo.all(query)
  end

  @spec get_cities(Ecto.Repo.t(), [integer()]) :: [City.t()] | no_return()
  def get_cities(repo, state_ids) when is_list(state_ids) do
    query = from(city in City, where: city.state_id in ^state_ids)
    repo.all(query)
  end

  @spec get_counties(Ecto.Repo.t(), [integer()]) :: [County.t()] | no_return()
  def get_counties(repo, state_ids) when is_list(state_ids) do
    query = from(county in County, where: county.state_id in ^state_ids)
    repo.all(query)
  end
end
