defmodule StrawHat.Map.Country do
  import Ecto.Query, only: [from: 2]

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
  def update_country(id, params) do
    with {:ok, country} <- find_country(id),
      do: update_country(country, params)
  end

  def destroy_country(%Country{} = country),
    do: Repo.delete(country)
  def destroy_country(id) do
    with {:ok, country} <- find_country(id),
      do: destroy_country(country)
  end

  def find_country(id) do
    case get_country(id) do
      nil -> {:error, {:not_found, "Country #{id} not found"}}
      country -> {:ok, country}
    end
  end

  def get_country(id),
    do: Repo.get(Country, id)

  def country_by_ids(country_ids) do
    query =
      from ct in Country,
      where: ct.id in ^country_ids
    Repo.all(query)
  end
end
