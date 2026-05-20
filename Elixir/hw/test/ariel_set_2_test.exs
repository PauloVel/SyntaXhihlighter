#    Tests for the set of problems by Ariel Ortiz
#    Applications of the general concepts of functional programming
#
#    To disable a test group, un-comment the line: "# #@describetag :optional" under the describe
#    or run the tests with: mix test --include optional
#
#    Gilberto Echeverria
#    2022_03_04

defmodule Hw.Ariel2Test do
  use ExUnit.Case
  alias Hw.Ariel2

  describe "insert:" do
    #@describetag :optional

    test "insert in empty list",
      do: assert(Ariel2.insert([], 14) == [14])

    test "insert at the beginning",
      do: assert(Ariel2.insert([5, 6, 7, 8], 4) == [4, 5, 6, 7, 8])

    test "insert in the middle",
      do: assert(Ariel2.insert([1, 3, 6, 7, 9, 16], 5) == [1, 3, 5, 6, 7, 9, 16])

    test "insert at the end",
      do: assert(Ariel2.insert([1, 5, 6], 10) == [1, 5, 6, 10])
  end

  describe "insertion_sort:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.insertion_sort([]) == [])

    test "unsorted list",
      do:
        assert(Ariel2.insertion_sort([4, 3, 6, 8, 3, 0, 9, 1, 7]) == [0, 1, 3, 3, 4, 6, 7, 8, 9])

    test "sorted list",
      do: assert(Ariel2.insertion_sort([1, 2, 3, 4, 5, 6]) == [1, 2, 3, 4, 5, 6])

    test "inverted list",
      do: assert(Ariel2.insertion_sort([6, 5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5, 6])

    test "repeated elements",
      do: assert(Ariel2.insertion_sort([5, 5, 5, 1, 5, 5, 5]) == [1, 5, 5, 5, 5, 5, 5])
  end

  describe "rotate_left: " do
   #@describetag :optional

    test "empty list",
      do: assert(Ariel2.rotate_left([], 5) == [])

    test "0 rotation",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 0) == [:a, :b, :c, :d, :e, :f, :g]
        )

    test "1 rotation",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 1) == [:b, :c, :d, :e, :f, :g, :a]
        )

    test "-1 rotation",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -1) == [:g, :a, :b, :c, :d, :e, :f]
        )

    test "3 rotation",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 3) == [:d, :e, :f, :g, :a, :b, :c]
        )

    test "-3 rotation",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -3) == [:e, :f, :g, :a, :b, :c, :d]
        )

    test "greater than length",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 8) == [:b, :c, :d, :e, :f, :g, :a]
        )

    test "negative greater than length",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -8) == [:g, :a, :b, :c, :d, :e, :f]
        )

    test "multiples of rotation 1",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], 45) == [:d, :e, :f, :g, :a, :b, :c]
        )

    test "negative multiples of rotation 1",
      do:
        assert(
          Ariel2.rotate_left([:a, :b, :c, :d, :e, :f, :g], -45) == [:e, :f, :g, :a, :b, :c, :d]
        )
  end

  describe "prime_factors:" do
    #@describetag :optional

    test "factor of 1",
      do: assert(Ariel2.prime_factors(1) == [])

    test "factors of 2",
      do: assert(Ariel2.prime_factors(2) == [2])

    test "factors of 6",
      do: assert(Ariel2.prime_factors(6) == [2, 3])

    test "factors of 17",
      do: assert(Ariel2.prime_factors(17) == [17])

    test "factors of 96",
      do: assert(Ariel2.prime_factors(96) == [2, 2, 2, 2, 2, 3])

    test "factors of 467",
      do: assert(Ariel2.prime_factors(467) == [467])

    test "factors of 666",
      do: assert(Ariel2.prime_factors(666) == [2, 3, 3, 37])
  end

  describe "gcd:" do
    #@describetag :optional

    test "gcd(0, 0)",
      do: assert(Ariel2.gcd(0, 0) == 0)

    test "gcd(3, 0)",
      do: assert(Ariel2.gcd(3, 0) == 3)

    test "gcd(0, 2)",
      do: assert(Ariel2.gcd(0, 2) == 2)

    test "gcd(2, 2)",
      do: assert(Ariel2.gcd(2, 2) == 2)

    test "gcd(10, 8)",
      do: assert(Ariel2.gcd(10, 8) == 2)

    test "gcd(8, 10)",
      do: assert(Ariel2.gcd(8, 10) == 2)

    test "gcd(270, 192)",
      do: assert(Ariel2.gcd(270, 192) == 6)

    test "gcd(13, 7919)",
      do: assert(Ariel2.gcd(13, 7919) == 1)

    test "gcd(20, 16)",
      do: assert(Ariel2.gcd(20, 16) == 4)

    test "gcd(54, 24)",
      do: assert(Ariel2.gcd(54, 24) == 6)

    test "gcd(6307, 1995)",
      do: assert(Ariel2.gcd(6307, 1995) == 7)
  end

  describe "deep_reverse:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.deep_reverse([]) == [])

    test "list with 2 elements",
      do: assert(Ariel2.deep_reverse([:a, :b]) == [:b, :a])

    test "list with 3 elements",
      do: assert(Ariel2.deep_reverse([:a, :b, :c]) == [:c, :b, :a])

    test "one nested list",
      do: assert(Ariel2.deep_reverse([:a, [:b, :c, :d], 3]) == [3, [:d, :c, :b], :a])

    test "two nested lists",
      do:
        assert(
          Ariel2.deep_reverse([:a, [:b, :c, :d], 3, [4, 5, 6]]) == [
            [6, 5, 4],
            3,
            [:d, :c, :b],
            :a
          ]
        )

    test "nested 2 deep",
      do: assert(Ariel2.deep_reverse([[1, 2], 3, [4, [5, 6]]]) == [[[6, 5], 4], 3, [2, 1]])
  end

  describe "insert at:" do
    #@describetag :optional

    test "insert in empty list" do
      assert(Ariel2.insert_at([], 0, :x) == [:x])
      assert(Ariel2.insert_at([], 5, :x) == [:x])
      assert(Ariel2.insert_at([], -5, :x) == [:x])
    end

    test "positive indices" do
      assert(Ariel2.insert_at([1, 2, 3], 0, :x) == [:x, 1, 2, 3])
      assert(Ariel2.insert_at([1, 2, 3], 1, :x) == [1, :x, 2, 3])
      assert(Ariel2.insert_at([1, 2, 3], 2, :x) == [1, 2, :x, 3])
      assert(Ariel2.insert_at([1, 2, 3], 3, :x) == [1, 2, 3, :x])
    end

    test "large positive indices" do
      assert(Ariel2.insert_at([1, 2, 3], 6, :x) == [1, 2, 3, :x])
      assert(Ariel2.insert_at([1, 2, 3], 9, :x) == [1, 2, 3, :x])
    end

    test "negative indices" do
      assert(Ariel2.insert_at([1, 2, 3], -4, :x) == [:x, 1, 2, 3])
      assert(Ariel2.insert_at([1, 2, 3], -3, :x) == [1, :x, 2, 3])
      assert(Ariel2.insert_at([1, 2, 3], -2, :x) == [1, 2, :x, 3])
      assert(Ariel2.insert_at([1, 2, 3], -1, :x) == [1, 2, 3, :x])
    end

    test "large negative indices" do
      assert(Ariel2.insert_at([1, 2, 3], -6, :x) == [:x, 1, 2, 3])
      assert(Ariel2.insert_at([1, 2, 3], -9, :x) == [:x, 1, 2, 3])
    end
  end

  describe "insert_everywhere:" do
    #@describetag :optional

    test "insert in empty list",
      do: assert(Ariel2.insert_everywhere([], :x) == [[:x]])

    test "insert in list with one element",
      do: assert(Ariel2.insert_everywhere([:a], :x) == [[:x, :a], [:a, :x]])

    test "insert in list with three elements",
      do:
        assert(
          Ariel2.insert_everywhere([:a, :b, :c], :x) ==
            [[:x, :a, :b, :c], [:a, :x, :b, :c], [:a, :b, :x, :c], [:a, :b, :c, :x]]
        )

    test "insert in list with five elements",
      do:
        assert(
          Ariel2.insert_everywhere([:a, :b, :c, :d, :e], :x) ==
            [
              [:x, :a, :b, :c, :d, :e],
              [:a, :x, :b, :c, :d, :e],
              [:a, :b, :x, :c, :d, :e],
              [:a, :b, :c, :x, :d, :e],
              [:a, :b, :c, :d, :x, :e],
              [:a, :b, :c, :d, :e, :x]
            ]
        )
  end

  # RLE

  describe "pack:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.pack([]) == [])

    test "list with 1 element",
      do: assert(Ariel2.pack([:a]) == [[:a]])

    test "list with multiple repeated elements",
      do:
        assert(
          Ariel2.pack([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
            [[:a, :a, :a, :a], [:b], [:c, :c], [:a, :a], [:d], [:e, :e, :e, :e]]
        )

    test "list with no repeated elements",
      do: assert(Ariel2.pack([1, 2, 3, 4, 5]) == [[1], [2], [3], [4], [5]])

    test "list with all repeated elements",
      do: assert(Ariel2.pack([9, 9, 9, 9, 9]) == [[9, 9, 9, 9, 9]])
  end

  describe "compress:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.compress([]) == [])

    test "list with 1 element",
      do: assert(Ariel2.compress([:a]) == [:a])

    test "list with multiple repeated elements",
      do:
        assert(
          Ariel2.compress([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
            [:a, :b, :c, :a, :d, :e]
        )

    test "list with no repeated elements",
      do: assert(Ariel2.compress([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5])

    test "list with all repeated elements",
      do: assert(Ariel2.compress([9, 9, 9, 9, 9]) == [9])
  end

  describe "encode:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.encode([]) == [])

    test "list with 1 element",
      do: assert(Ariel2.encode([:a]) == [{1, :a}])

    test "list with multiple repeated elements",
      do:
        assert(
          Ariel2.encode([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
            [{4, :a}, {1, :b}, {2, :c}, {2, :a}, {1, :d}, {4, :e}]
        )

    test "list with no repeated elements",
      do: assert(Ariel2.encode([1, 2, 3, 4, 5]) == [{1, 1}, {1, 2}, {1, 3}, {1, 4}, {1, 5}])

    test "list with all repeated elements",
      do: assert(Ariel2.encode([9, 9, 9, 9, 9]) == [{5, 9}])
  end

  describe "encode_modified:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.encode_modified([]) == [])

    test "list with 1 element",
      do: assert(Ariel2.encode_modified([:a]) == [:a])

    test "list with multiple repeated elements",
      do:
        assert(
          Ariel2.encode_modified([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) ==
            [{4, :a}, :b, {2, :c}, {2, :a}, :d, {4, :e}]
        )

    test "list with no repeated elements",
      do: assert(Ariel2.encode_modified([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5])

    test "list with all repeated elements",
      do: assert(Ariel2.encode_modified([9, 9, 9, 9, 9]) == [{5, 9}])
  end

  describe "decode:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.decode([]) == [])

    test "list with 1 element",
      do: assert(Ariel2.decode([:a]) == [:a])

    test "list with multiple repeated elements",
      do:
        assert(
          Ariel2.decode([{4, :a}, :b, {2, :c}, {2, :a}, :d, {4, :e}]) ==
            [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]
        )

    test "list with no repeated elements",
      do: assert(Ariel2.decode([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5])

    test "list with all repeated elements",
      do: assert(Ariel2.decode([{5, 9}]) == [9, 9, 9, 9, 9])
  end

  describe "args_swap:" do
    #@describetag :optional

    test "swapping a custom function to create pairs",
      do: assert(Ariel2.args_swap(&{&1, &2}).(1, 2) == {2, 1})

    test "swapping the division function",
      do: assert(Ariel2.args_swap(&Kernel.//2).(8, 2) == 0.25)

    # test "swapping the cons function",
    # do: assert Ariel2.args_swap(cons).([1, 2, 3], [4, 5, 6]) == [(4, 5, 6], 1, 2, 3)
    test "swapping the map function",
      do:
        assert(
          Ariel2.args_swap(&Enum.map/2).(&(1 / &1), [-1, 1, 2, 5, 10]) == [-1, 1, 0.5, 0.2, 0.1]
        )
  end

  describe "there_exists_one?:" do
    #@describetag :optional

    test "Positive on an empty list",
      do: assert(Ariel2.there_exists_one?(&(&1 >= 0), []) == false)

    test "Positive on a list with one positive",
      do: assert(Ariel2.there_exists_one?(&(&1 >= 0), [-1, -10, 4, -5, -2, -1]) == true)

    test "Positive on a list with many positives",
      do: assert(Ariel2.there_exists_one?(&(&1 >= 0), [-1, -10, 4, -5, 2, -1]) == false)

    test "Negative on a list with one negative",
      do: assert(Ariel2.there_exists_one?(&(&1 < 0), [-1]) == true)

    test "is_atom on a list with no atoms",
      do: assert(Ariel2.there_exists_one?(&is_atom/1, [4, 8, 15, 16, 23, 42]) == false)

    test "is_atom on a list with one atom",
      do: assert(Ariel2.there_exists_one?(&is_atom/1, [4, 8, 15, :sixteen, 23, 42]) == true)

    test "is_atom on a list with multiple atoms",
      do:
        assert(Ariel2.there_exists_one?(&is_atom/1, [4, :eight, 15, :sixteen, 23, :ten]) == false)
  end

  describe "linear_search:" do
    #@describetag :optional

    test "empty list",
      do: assert(Ariel2.linear_search([], 5, &Kernel.==/2) == false)

    test "compare numbers",
      do:
        assert(
          Ariel2.linear_search(
            [48, 77, 30, 31, 5, 20, 91, 92, 69, 97, 28, 32, 17, 18, 96],
            5,
            &Kernel.==/2
          ) == 4
        )

    test "compare strings",
      do:
        assert(
          Ariel2.linear_search(
            ["red", "blue", "green", "black", "white"],
            "black",
            &String.equivalent?/2
          ) == 3
        )

    test "compare atoms",
      do: assert(Ariel2.linear_search([:a, :b, :c, :d, :e, :f, :g, :h], :h, &Kernel.==/2) == 7)

    test "string contains",
      do:
        assert(
          Ariel2.linear_search(
            ["terminal", "keyboard", "mouse", "monitor"],
            "ous",
            &String.contains?/2
          ) == 2
        )

    test "custom compare function",
      do:
        assert(
          Ariel2.linear_search(
            [34, 83, 13, 45, 87, 17],
            20,
            &(&1 < &2)
          ) == 2
        )
  end

  describe "deriv:" do
    #@describetag :optional

    test "first derivate" do
      f = fn x -> x ** 3 end
      df = Ariel2.deriv(f, 0.001)
      assert_in_delta(df.(5), 75.0, 0.02)
    end

    test "second derivate" do
      f = fn x -> x ** 3 end
      df = Ariel2.deriv(f, 0.001)
      ddf = Ariel2.deriv(df, 0.001)
      assert_in_delta(ddf.(5), 30.0, 0.01)
    end

    test "third derivate" do
      f = fn x -> x ** 3 end
      df = Ariel2.deriv(f, 0.001)
      ddf = Ariel2.deriv(df, 0.001)
      dddf = Ariel2.deriv(ddf, 0.001)
      assert_in_delta(dddf.(5), 6.0, 0.01)
    end
  end

  describe "newton" do
    #@describetag :optional

    test "root of x-10",
      do: assert_in_delta(Ariel2.newton(fn x -> x - 10 end, 1), 10.0, 0.0001)

    test "root of 4x+2",
      do: assert_in_delta(Ariel2.newton(fn x -> 4 * x + 2 end, 1), -0.5, 0.0001)

    test "root of x³+1",
      do: assert_in_delta(Ariel2.newton(fn x -> x ** 3 + 1 end, 50), -1.0, 0.0001)

    test "root of cos(x)+(x/2)",
      do: assert_in_delta(Ariel2.newton(fn x -> :math.cos(x) + x / 2 end, 5), -1.03, 0.001)
  end

  describe "integral" do
    #@describetag :optional

    test "x³ from 0 to 1, 10 iterations",
      do: assert_in_delta(Ariel2.integral(0, 1, 10, fn x -> x ** 3 end), 1 / 4, 0.0001)

    test "x*y integral over x:[1-2] and y:[3-4], 10 iterations",
      do:
        assert_in_delta(
          Ariel2.integral(1, 2, 10, fn x -> Ariel2.integral(3, 4, 10, fn y -> x * y end) end),
          21 / 4,
          0.0001
        )
  end
end
