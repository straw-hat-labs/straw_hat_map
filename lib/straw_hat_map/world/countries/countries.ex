defmodule StrawHat.Map.Countries do
  @moduledoc """
  Countries management use cases.
  """

  import Ecto.Query
  alias StrawHat.{Error, Response}
  alias StrawHat.Map.{Country, State}

  @spec get_countries(Ecto.Repo.t(), Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_countries(repo, pagination \\ []) do
    repo.paginate(Country, pagination)
  end

  @spec create_country(Ecto.Repo.t(), Country.country_attrs()) ::
          Response.t(Country.t(), Ecto.Changeset.t())
  def create_country(repo, country_attrs) do
    %Country{}
    |> Country.changeset(country_attrs)
    |> repo.insert()
    |> Response.from_value()
  end

  @spec update_country(Ecto.Repo.t(), Country.t(), Country.country_attrs()) ::
          Response.t(Country.t(), Ecto.Changeset.t())
  def update_country(repo, %Country{} = country, country_attrs) do
    country
    |> Country.changeset(country_attrs)
    |> repo.update()
    |> Response.from_value()
  end

  @spec destroy_country(Ecto.Repo.t(), Country.t()) :: Response.t(Country.t(), Ecto.Changeset.t())
  def destroy_country(repo, %Country{} = country) do
    country
    |> repo.delete()
    |> Response.from_value()
  end

  @spec find_country(Ecto.Repo.t(), String.t()) :: Response.t(Country.t(), Error.t())
  def find_country(repo, country_id) do
    repo
    |> get_country(country_id)
    |> Response.from_value(
      Error.new("straw_hat_map.country.not_found", metadata: [country_id: country_id])
    )
  end

  @spec get_country(Ecto.Repo.t(), String.t()) :: Country.t() | nil | no_return
  def get_country(repo, country_id) do
    repo.get(Country, country_id)
  end

  @spec get_countries_by_ids(Ecto.Repo.t(), [integer()]) :: [Country.t()] | no_return()
  def get_countries_by_ids(repo, country_ids) do
    Country
    |> select([country], country)
    |> where([country], country.id in ^country_ids)
    |> repo.all()
  end

  @spec get_states(Ecto.Repo.t(), [integer()]) :: [State.t()] | no_return()
  def get_states(repo, country_ids) when is_list(country_ids) do
    State
    |> select([state], state)
    |> where([state], state.country_id in ^country_ids)
    |> repo.all()
  end
end
