defmodule StrawHat.Map.EctoRegexTypeTests do
  use StrawHat.Map.Tests.CaseTemplate, async: true
  alias StrawHat.Map.Ecto.Types.Regex

  describe "cast" do
    test "with a string value" do
      assert {:ok, _value} = Regex.cast("\\d")
    end

    test "with a non-regex value" do
      assert :error = Regex.cast(:atom)
    end
  end

  describe "load" do
    test "with a regex value" do
      assert {:ok, _value} = Regex.load("\\d")
    end

    test "with a non-regex value" do
      assert :error = Regex.load(:atom)
    end
  end
end
