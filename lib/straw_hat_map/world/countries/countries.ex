defmodule StrawHat.Map.Countries do
  @moduledoc """
  Defines functionality for countries management.
  """

  import Ecto.Query, only: [from: 2]
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.{Country, State}
  alias StrawHat.Map.Repo

  @doc """
  Gets the list of countries.
  """
  @spec get_countries(Ecto.Repo, Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_countries(repo, pagination \\ []) do
    repo.paginate(Country, pagination)
  end

  @doc """
  Creates a country.
  """
  @spec create_country(Ecto.Repo, Country.country_attrs()) :: Response.t(Country.t(), Ecto.Changeset.t())
  def create_country(repo, country_attrs) do
    %Country{}
    |> Country.changeset(country_attrs)
    |> repo.insert()
    |> Response.from_value()
  end

  @doc """
  Updates a country.
  """
  @spec update_country(Ecto.Repo, Country.t(), Country.country_attrs()) ::
          Response.t(Country.t(), Ecto.Changeset.t())
  def update_country(repo, %Country{} = country, country_attrs) do
    country
    |> Country.changeset(country_attrs)
    |> repo.update()
    |> Response.from_value()
  end

  @doc """
  Destroys a country.
  """
  @spec destroy_country(Ecto.Repo, Country.t()) :: Response.t(Country.t(), Ecto.Changeset.t())
  def destroy_country(repo, %Country{} = country) do
    country
    |> repo.delete()
    |> Response.from_value()
  end

  @doc """
  Gets a country by `id`.
  """
  @spec find_country(String.t()) :: Response.t(Country.t(), Error.t())
  def find_country(country_id) do
    country_id
    |> get_country()
    |> Response.from_value(
      Error.new("straw_hat_map.country.not_found", metadata: [country_id: country_id])
    )
  end

  @doc """
  Gets a country by `id`.
  """
  @spec get_country(String.t()) :: Country.t() | nil | no_return
  def get_country(country_id) do
    Repo.get(Country, country_id)
  end

  @doc """
  Gets list of countries.
  """
  @spec get_countries_by_ids([integer()]) :: [Country.t()] | no_return()
  def get_countries_by_ids(country_ids) do
    query = from(country in Country, where: country.id in ^country_ids)
    Repo.all(query)
  end

  @doc """
  Gets list of states.
  """
  @spec get_states([integer()]) :: [State.t()] | no_return()
  def get_states(country_ids) when is_list(country_ids) do
    query = from(state in State, where: state.country_id in ^country_ids)
    Repo.all(query)
  end
end
