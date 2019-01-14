defmodule StrawHat.Map.Tests.IsoGenerator do
  use Agent

  @initial_state %{
    two: [],
    three: [],
    numeric: [],
  }

  def start_link() do
    Agent.start_link(fn -> @initial_state end, name: __MODULE__)
  end

  def generate_iso(type) do
    Agent.get_and_update(__MODULE__, fn state ->
      generate_and_update(state, type)
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn -> [] end)
  end

  defp generate_and_update(state, type) do
    new_iso = generate_numeric_combination(type)

    state
    |> find_iso(type, new_iso)
    |> with_found_iso_numeric(state, type, new_iso)
  end

  defp with_found_iso_numeric(nil, state, type, new_iso) do
    updated_list =
      state
      |> Map.get(type)
      |> Enum.concat([new_iso])
    state = Map.put(state, type, updated_list)

    {new_iso, state}
  end

  defp with_found_iso_numeric(_, state, type, _) do
    generate_and_update(state, type)
  end

  defp find_iso(state, type, new_iso) do
    state
    |> Map.get(type)
    |> Enum.find_index(fn current_number ->
      current_number == new_iso
    end)
  end

  defp generate_numeric_combination(:two) do
    Faker.format("??")
  end

  defp generate_numeric_combination(:three) do
    Faker.format("???")
  end

  defp generate_numeric_combination(:numeric) do
    "#{:rand.uniform(9)}#{:rand.uniform(9)}#{:rand.uniform(9)}"
  end
end
