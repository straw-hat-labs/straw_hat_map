defmodule StrawHat.Map.EctoRegexTest do
  use StrawHat.Map.Test.DataCase, async: true
  alias StrawHat.Map.Ecto.Regex

  describe "cast/1" do
    test "with a regex value" do
      assert {:ok, _value} = Regex.cast(~r/\d/)
    end

    test "with a non-regex value" do
      assert :error = Regex.cast(:atom)
    end
  end

  describe "load/1" do
    test "with a regex value" do
      assert {:ok, _value} = Regex.load("\\d")
    end

    test "with a non-regex value" do
      assert :error = Regex.load(:atom)
    end
  end
end
