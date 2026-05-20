defmodule Qus do
    #iex> Qus.dfa_paraser("abdcbdbad",{&Qus.delta_a_dc_b/2, :q0, [:q4]})
    #true
  def dfa_paraser(string,{delta,q0,accept})do
    string
    |>String.graphemes() #split a string in a set of characters
    |>dfa_step(delta,q0,accept)

  end
  def dfa_step([],_delta,state,accept), do: Enum.member?(accept,state)
  def dfa_step([head | tail],delta,state,accept), do: dfa_step(tail,delta,delta.(state,head),accept)

  def delta_number(state, char), do:
    case state do
      :start -> cond do
        char in ["+", "-"] -> :integer
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :integer
        true -> :error
      end
      :integer -> cond do
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :integer
        char in ["."] -> :dot
        char in ["e", "E"] -> :exponent
        true -> :error
      end
      :dot -> cond do
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :float
        true -> :error
      end
      :float -> cond do
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :float
        char in ["e", "E"] -> :exponent
        true -> :error
      end
      :exponent -> cond do
        char in ["+", "-"] -> :e_sign
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :e_integer
        true -> :error
      end
      :e_sign -> cond do
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :e_integer
        true -> :error
      end
      :e_integer -> cond do
        char in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] -> :e_integer
        true -> :error
      end
    end

  end
  def delta_a_dc_b(state, char) do
        case state do
            :q0 -> case char do
                "a" -> :q1
                # We don't care for any other value. They are all errors.
                _ -> :err
            end

            :q1 -> case char do
                "a" -> :q1
                "b" -> :q1
                "c" -> :q1
                "d" -> :q2
                _ -> :err
            end

            :q2 -> case char do
                "a" -> :q1
                "b" -> :q1
                "c" -> :q3
                "d" -> :q1
                _ -> :err
            end

            :q3 -> case char do
                "a" -> :q3
                "b" -> :q4
                "c" -> :q3
                "d" -> :q3
                _ -> :err
            end

            :q4 -> case char do
                "a" -> :q3
                "b" -> :q4
                "c" -> :q3
                "d" -> :q3
                _ -> :err
            end

            # Any error will remain as error
            :err -> :err
  end

end

defmodule Qus do
  def
end
