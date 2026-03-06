defmodule HwTest do
  use ExUnit.Case
  doctest Hw

  test "greets the world" do
    assert Hw.hello() == :world
  end
end
