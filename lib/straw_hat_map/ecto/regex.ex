defmodule StrawHat.Map.Ecto.Regex do
  @moduledoc """
  Adds regular expressions as a custom Ecto Type.
  """

  @behaviour Ecto.Type

  def type, do: :string

  @spec cast(String.t()) :: {:ok, String.t()} | :error
  def cast(value) when is_binary(value) do
    case Regex.compile(value) do
      {:ok, _} -> {:ok, value}
      _ -> :error
    end
  end

  def cast(_), do: :error

  @spec load(String.t()) :: {:ok, Regex.t()} | :error
  def load(regex) when is_binary(regex) do
    Regex.compile(regex)
  end

  def load(_), do: :error

  @spec dump(String.t()) :: {:ok, String.t()} | :error
  def dump(regex) when is_binary(regex), do: {:ok, regex}
  def dump(_), do: :error
end
