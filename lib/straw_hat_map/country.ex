defmodule StrawHat.Map.Country do
  alias StrawHat.Map.Query.Country, as: CountryQuery
  alias StrawHat.Error
  alias StrawHat.Map.Repo
  alias StrawHat.Map.Schema.Country

  def list_countries(params), do: Repo.paginate(Country, params)

  def create_country(params) do
    %Country{}
    |> Country.changeset(params)
    |> Repo.insert()
  end

  def update_country(%Country{} = country, params) do
    country
    |> Country.changeset(params)
    |> Repo.update()
  end

  def destroy_country(%Country{} = country), do: Repo.delete(country)

  def find_country(id) do
    case get_country(id) do
      nil -> {:error, Error.new("map.country.not_found", metadata: [id: id])}
      country -> {:ok, country}
    end
  end

  def get_country(id), do: Repo.get(Country, id)

  def country_by_ids(country_ids) do
    Country
    |> CountryQuery.by_ids(country_ids)
    |> Repo.all()
  end
end
