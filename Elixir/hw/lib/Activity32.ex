defmodule Numeros do
  # Entry point
  def arithmetic_lexer(string) do
    dfa_parser(string, {&Numeros.delta_number/2, :start, [:int, :float, :exp, :var, :par_close]})
  end

  # Converts string to list of characters and kicks off the recursion
  def dfa_parser(string, {delta, q0, accept}) do
    string
    |> String.graphemes()
    |> dfa_step(delta, q0, accept, [], "")
  end

  # we ran out of characters. Check if we landed in an "accept" state
  def dfa_step([], _delta, state, accept, types, current) do
    if Enum.member?(accept, state) do
      token = pack_token(state, current)
      Enum.reverse([token | types])
    else
      false # If it doesn't end right, it's not valid
    end
  end

  # token
  def dfa_step([head | tail], delta, state, accept, types, current) do
    [new_state, found] = delta.(state, head)
    if found do
      # Save it and start the next one with 'head'
      token = pack_token(found, current)
      dfa_step(tail, delta, new_state, accept, [token | types], head)
    else
      # Keep building the current token
      dfa_step(tail, delta, new_state, accept, types, current <> head)
    end
  end

  # Helper to format the output nicely (keeps dfa_step clean)
  defp pack_token(type, val) do
    case type do
      :int    -> {:int, String.to_integer(val)}
      :float  -> {:float, String.to_float(val)}
      :oper   -> {:op, val}
      :par_o  -> {:par_open, "("}
      :par_c  -> {:par_close, ")"}
      _       -> {type, val}
    end
  end

  def delta_number(state, char) do
    case state do
      :start ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:int, false]
          char in ["+", "-"] -> [:sign, false]
          char in String.graphemes("abcdefghijklmnopqrstuvwxyz") -> [:var, false]
          char == "(" -> [:par_o, false]
          true -> [:err, false]
        end

      :sign ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:int, false]
          true -> [:err, false]
        end

      :int ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:int, false]
          char == "." -> [:dot, false]
          char in ["e", "E"] -> [:e, false]
          char in ["+", "-", "*", "/", "%", "=", "^"] -> [:oper, :int]
          char == ")" -> [:par_c, :int]
          true -> [:err, false]
        end

      :dot ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:float, false]
          true -> [:err, false]
        end

      :float ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:float, false]
          char in ["e", "E"] -> [:e, false]
          char in ["+", "-", "*", "/", "%", "=", "^"] -> [:oper, :float]
          char == ")" -> [:par_c, :float]
          true -> [:err, false]
        end

      :e ->
        cond do
          char in ["+", "-"] -> [:e_sign, false]
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:exp, false]
          true -> [:err, false]
        end

      :e_sign ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:exp, false]
          true -> [:err, false]
        end

      :exp ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:exp, false]
          char in ["+", "-", "*", "/", "%", "=", "^"] -> [:oper, :exp]
          char == ")" -> [:par_c, :exp]
          true -> [:err, false]
        end

      :var ->
        cond do
          char in String.graphemes("abcdefghijklmnopqrstuvwxyz0123456789_") -> [:var, false]
          char in ["+", "-", "*", "/", "%", "=", "^"] -> [:oper, :var]
          char == ")" -> [:par_c, :var]
          true -> [:err, false]
        end

      :oper ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:int, :oper]
          char in String.graphemes("abcdefghijklmnopqrstuvwxyz") -> [:var, :oper]
          char == "(" -> [:par_o, :oper]
          char in ["+", "-"] -> [:sign, :oper]
          true -> [:err, false]
        end

      :par_o ->
        cond do
          char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> [:int, false]
          char in String.graphemes("abcdefghijklmnopqrstuvwxyz") -> [:var, false]
          char == "(" -> [:par_o, false]
          char in ["+", "-"] -> [:sign, false]
          true -> [:err, false]
        end

      :par_c ->
        cond do
          char in ["+", "-", "*", "/", "%", "=", "^"] -> [:oper, :par_c]
          char == ")" -> [:par_c, :par_c]
          true -> [:err, false]
        end

      :err -> [:err, false]
    end
  end
end
