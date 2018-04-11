defmodule StrawHat.Map.Ecto.Regex do
  @moduledoc """
  Adds regular expressions as a custom Ecto Type
  """

  @behaviour Ecto.Type
  def type, do: :string

  @doc """
  Cast regular expressions into strings
  """
  @spec cast(Regex.t) :: {:ok, String.t} | :error
  def cast(regex) do
    case Regex.regex?(regex) do
      true -> {:ok, Regex.source(regex)}
      false -> :error
    end
  end

  @doc """
  Loads the stored data as a regular expression
  """
  @spec load(String.t) :: {:ok, Regex.t} | :error
  def load(regex) when is_binary(regex) do
    Regex.compile(regex)
  end

  @spec dump(String.t) :: {:ok, String.t} | :error
  def dump(regex) when is_binary(regex), do: {:ok, regex}
  def dump(_), do: :error
end
