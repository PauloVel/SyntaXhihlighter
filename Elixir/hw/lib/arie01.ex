# Paulo Velez A01787207
# Solutions for Problems 1-20

defmodule Hw.Ariel1 do

  # 1. fahrenheit_to_celsius
  def fahrenheit_to_celsius(f), do: (5 * (f - 32)) / 9

  # 2. roots
  def roots(a, b, c), do: (-b + :math.sqrt(:math.pow(b, 2) - 4 * a * c)) / (2 * a)

  # 3. sign
  def sign(n) when n < 0, do: -1
  def sign(n) when n > 0, do: 1
  def sign(0), do: 0

  # 4. bmi  
  def bmi(weight, height) do
    index = weight / (height * height)
    cond do
      index < 20 -> :underweight
      index < 25 -> :normal
      index < 30 -> :obese1
      index < 40 -> :obese2
      true       -> :obese3
    end
  end

  # 5. factorial (Body Recursion like your 02recursion.exs)
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)

  # 6. pow
  def pow(_, 0), do: 1
  def pow(a, b), do: a * pow(a, b - 1)

  # 7. fib
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)

  # 8. duplicate: [1, 2] -> [1, 1, 2, 2]
  def duplicate([]), do: []
  def duplicate([h | t]), do: [h, h | duplicate(t)]

  # 9. enlist: [1, 2] -> [[1], [2]]
  def enlist([]), do: []
  def enlist([h | t]), do: [[h] | enlist(t)]

  # 10. positives
  def positives([]), do: []
  def positives([h | t]) when h > 0, do: [h | positives(t)]
  def positives([_h | t]), do: positives(t)

  # 11. add_list
  def add_list([]), do: 0
  def add_list([h | t]), do: h + add_list(t)

  # 12. invert_pairs: [{1, 2}] -> [{2, 1}]
  # Fixed: Tests use Tuples {}, not Lists []
  def invert_pairs([]), do: []
  def invert_pairs([{a, b} | t]), do: [{b, a} | invert_pairs(t)]

  # 13. is_atom_list (Renamed from list_of_symbols? to match tests)
  def is_atom_list([]), do: true
  def is_atom_list([h | t]) when is_atom(h), do: is_atom_list(t)
  def is_atom_list(_), do: false

  # 14. swapper
  def swapper([], _, _), do: []
  def swapper([h | t], a, b) do
    new_h = cond do
      h == a -> b
      h == b -> a
      true   -> h
    end
    [new_h | swapper(t, a, b)]
  end

  # 15. dot_product
  def dot_product([], []), do: 0
  def dot_product([ha | ta], [hb | tb]), do: (ha * hb) + dot_product(ta, tb)

  # 16. average
  def average([]), do: 0
  def average(lst), do: add_list(lst) / length(lst)

  # 17. std_dev (Renamed from standard_deviation to match tests)
  def std_dev([]), do: 0
  def std_dev(lst) do
    avg = average(lst)
    :math.sqrt(sum_sq_diff(lst, avg) / length(lst))
  end

  defp sum_sq_diff([], _), do: 0
  defp sum_sq_diff([h | t], avg), do: :math.pow(h - avg, 2) + sum_sq_diff(t, avg)

  # 18. replic (Fixed: Argument order changed to match tests: n, lst)
  def replic(_, []), do: []
  def replic(0, _), do: []
  def replic(n, [h | t]), do: replicate_element(h, n) ++ replic(n, t)

  defp replicate_element(_, 0), do: []
  defp replicate_element(val, n), do: [val | replicate_element(val, n - 1)]

  # 19. expand
  def expand(lst), do: do_expand(lst, 1)
  defp do_expand([], _), do: []
  defp do_expand([h | t], n), do: replicate_element(h, n) ++ do_expand(t, n + 1)

  # 20. binary
  def binary(0), do: []
  def binary(n), do: binary(div(n, 2)) ++ [rem(n, 2)]

end
