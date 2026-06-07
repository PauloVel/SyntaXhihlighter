# To run this: elixir test_numeros.exs

IO.puts "--- Starting Tests ---"

tests = [
  {"a=5+b", true},                   # Valid variable and math
  {"32.4*(-8.6-b)", true},           # Valid float and parentheses
  {"6.1E-8", true},                  # Valid scientific notation
  {"_var1", false},                  # Invalid: doesn't start with letter
  {"a+-b", false},                   # Invalid: bad operator placement
  {"(5+2))", false},                 # Invalid: extra parenthesis
  {"7+", false}                      # Invalid: ends with operator
]

Enum.each(tests, fn {input, expected} ->
  result = Numeros.arithmetic_lexer(input)
  passed = if (expected == false), do: result == false, else: is_list(result)

  status = if passed, do: "PASS", else: "FAIL"
  IO.puts "[#{status}] Input: #{input}"
end)

IO.puts "--- Tests Complete ---"
