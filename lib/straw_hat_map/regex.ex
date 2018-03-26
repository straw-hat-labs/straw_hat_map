defmodule StrawHat.Map.Regex do
  @behaviour Ecto.Type
  def type, do: :string

  @spec cast(Regex.t) :: {:ok, String.t} | :error
  def cast(regex) do
    case Regex.regex?(regex) do
      true -> {:ok, Regex.source(regex)}
      false -> :error
    end  
  end

  @spec load(String.t) :: {:ok, Regex.t} | :error
  def load(regex) when is_binary(regex) do
    Regex.compile(regex)
  end

  @doc """
  When dumping data to the database, we *expect* our casted type as a string
    iex> Regex.dump("foo")
    {:ok, "foo"}
    iex> Regex.dump(1)
    :error
  """
  @spec dump(String.t) :: {:ok, String.t} | :error
  def dump(regex) when is_binary(regex), do: {:ok, regex}
  def dump(_), do: :error
end