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
  def cast(value) when is_binary(value) do
    value
    |> Regex.compile()
    |> with_valid_regex(value)
  end

  def cast(value) do
    if Regex.regex?(value) do
      {:ok, Regex.source(value)}
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

  @spec with_valid_regex({:ok, Regex.t()} | {:error, any()}, String.t()) :: {:ok, String.t()} | :error
  defp with_valid_regex({:ok, _}, value), do: {:ok, value}
  defp with_valid_regex(_, _), do: :error
end
