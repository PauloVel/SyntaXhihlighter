# Paulo Velez A01787207
# Solutions for Problems 1-18

defmodule Hw.Ariel2 do

  # 1. insert
  def insert([], n), do: [n]
  def insert([h | t], n) when n <= h, do: [n, h | t]
  def insert([h | t], n), do: [h | insert(t, n)]

  # 2. insertion_sort
  def insertion_sort([]), do: []
  def insertion_sort([h | t]), do: insert(insertion_sort(t), h)

  # insert_at: paara la test
  def insert_at(lst, n, z) do
    len = length(lst)
    idx = cond do
      n < 0 -> 
        calculated = len + n + 1
        if calculated < 0, do: 0, else: calculated
      n > len -> len
      true -> n
    end
    {left, right} = Enum.split(lst, idx)
    left ++ [z | right]
  end

  # 3. rotate_left
  def rotate_left([], _), do: []
  def rotate_left(lst, 0), do: lst
  def rotate_left(lst, n) do
    len = length(lst)
    m = rem(n, len)
    shift = if m < 0, do: len + m, else: m
    {left, right} = Enum.split(lst, shift)
    right ++ left
  end

  # 4. prime_factors
  def prime_factors(n), do: do_prime_factors(n, 2)
  defp do_prime_factors(n, i) when n < 2, do: []
  defp do_prime_factors(n, i) when rem(n, i) == 0, do: [i | do_prime_factors(div(n, i), i)]
  defp do_prime_factors(n, i), do: do_prime_factors(n, i + 1)

  # 5. gcd
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))

  # 6. deep_reverse
  def deep_reverse(lst), do: do_deep_reverse(lst, [])
  defp do_deep_reverse([], acc), do: acc
  defp do_deep_reverse([h | t], acc) when is_list(h), 
    do: do_deep_reverse(t, [deep_reverse(h) | acc])
  defp do_deep_reverse([h | t], acc), 
    do: do_deep_reverse(t, [h | acc])

  # 7. insert_everywhere
  def insert_everywhere(lst, z), do: do_insert_everywhere(z, [], lst)
  defp do_insert_everywhere(z, pre, []), do: [pre ++ [z]]
  defp do_insert_everywhere(z, pre, [h | t]) do
    [pre ++ [z | [h | t]]] ++ do_insert_everywhere(z, pre ++ [h], t)
  end

  # 8. pack
  def pack([]), do: []
  def pack([h | t]), do: do_pack(t, [h], [])
  defp do_pack([], current, acc), do: Enum.reverse([current | acc])
  defp do_pack([h | t], [h | _] = current, acc), do: do_pack(t, [h | current], acc)
  defp do_pack([h | t], current, acc), do: do_pack(t, [h], [current | acc])

  # 9. compress
  def compress([]), do: []
  def compress([h | t]), do: [h | do_compress(t, h)]
  defp do_compress([], _), do: []
  defp do_compress([h | t], h), do: do_compress(t, h)
  defp do_compress([h | t], _), do: [h | do_compress(t, h)]

  # 10. encode
  def encode(lst) do
    pack(lst) |> Enum.map(fn group -> {length(group), hd(group)} end)
  end

  # 11. encode_modified
  def encode_modified(lst) do
    pack(lst) 
    |> Enum.map(fn 
      [h] -> h
      group -> {length(group), hd(group)} 
    end)
  end

  # 12. decode
  def decode([]), do: []
  def decode([{n, e} | t]), do: List.duplicate(e, n) ++ decode(t)
  def decode([h | t]), do: [h | decode(t)]

  # 13. args_swap
  def args_swap(f) do
    fn x, y -> f.(y, x) end
  end

  # 14. there_exists_one?
  def there_exists_one?(pred, lst) do
    Enum.count(lst, pred) == 1
  end

  # 15. linear_search
  def linear_search(lst, z, eq_fun), do: do_linear_search(lst, z, eq_fun, 0)
  defp do_linear_search([], _, _, _), do: false
  defp do_linear_search([h | t], z, eq_fun, idx) do
    if eq_fun.(h, z), do: idx, else: do_linear_search(t, z, eq_fun, idx + 1)
  end

  # 16. deriv
  def deriv(f, h) do
    fn x -> (f.(x + h) - f.(x)) / h end
  end 
end