defmodule Geo.Ecto.Changeset do
  alias Ecto.Changeset

  @default_decoder Geo.JSON

  def validate_geo_format(changeset, field_name, opts \\ [])
  def validate_geo_format(%Changeset{valid?: false} = changeset, _, _), do: changeset

  def validate_geo_format(changeset, field_name, opts) do
    changeset
    |> Changeset.get_field(field_name)
    |> decode(opts)
    |> with_valid_format(changeset, field_name, opts)
  end

  defp message(opts, key \\ :message, default) do
    Keyword.get(opts, key, default)
  end

  defp with_valid_format({:ok, _value}, changeset, _field_name, _opts), do: changeset

  defp with_valid_format({:error, _error}, changeset, field_name, opts) do
    message = message(opts, "is invalid")
    Changeset.add_error(changeset, field_name, message, validation: :geojson_format)
  end

  defp decode(value, opts) do
    decoder = Keyword.get(opts, :decoder, @default_decoder)
    decoded_value = decoder.decode(value)
    {:ok, decoded_value}
  rescue
    # TODO use this when https://github.com/bryanjos/geo/pull/83
    # get merge, hopefully
    Geo.JSON.DecodeError ->
      {:error, nil}
  end
end
