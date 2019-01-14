defmodule StrawHat.Map.Tests.IsoGeneratorServer do
  @moduledoc """
  GenServer for generating ISO codes.
  """

  use Agent

  alias StrawHat.Map.Tests.IsoGenerator

  def start_link() do
    Agent.start_link(&IsoGenerator.initial_state/0, name: __MODULE__)
  end

  def generate_iso(type) do
    Agent.get_and_update(__MODULE__, &IsoGenerator.generate_iso(&1, type))
  end

  def reset do
    Agent.update(__MODULE__, &IsoGenerator.initial_state/0)
  end
end
