defmodule StrawHat.Map.Ecto.Regex do
  @moduledoc """
  Adds regular expressions as a custom Ecto Type
  """

  @behaviour Ecto.Type
  def type, do: :string

  @doc """
  Cast regular expressions into strings
  """
  @spec cast(Regex.t()) :: {:ok, String.t()} | :error
  def cast(regex) do
    if Regex.regex?(regex) do
      {:ok, Regex.source(regex)}
    else
      :error
    end
  end

  @doc """
  Loads the stored data as a regular expression
  """
  @spec load(String.t()) :: {:ok, Regex.t()} | :error
  def load(regex) when is_binary(regex) do
    Regex.compile(regex)
  end
  def load(_), do: :error

  @spec dump(String.t()) :: {:ok, String.t()} | :error
  def dump(regex) when is_binary(regex), do: {:ok, regex}
  def dump(_), do: :error
end
