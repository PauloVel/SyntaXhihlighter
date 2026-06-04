defmodule MiniLexer do
  @matriz_transiciones [
    [   0,      1,      2,      3  ],
    [  10,      1,     10,     10  ],
    [  11,     11,      2,     11  ],
    [  12,     12,     12,     12  ]
  ]

  def clasificar_caracter(char) do
    cond do
      char in [" ", "\n", "\t"] -> 0
      char =~ ~r/[a-zA-Z]/      -> 1
      char =~ ~r/[0-9]/         -> 2
      char in ["+", "-", "="]   -> 3
      true                      -> 0
    end
  end

  def obtener_siguiente_estado(estado_actual, columna) do
    @matriz_transiciones
    |> Enum.at(estado_actual)
    |> Enum.at(columna)
  end

  def es_estado_aceptacion?(estado) do
    estado >= 10
  end

  def obtener_tipo_token(10), do: :palabra
  def obtener_tipo_token(11), do: :numero
  def obtener_tipo_token(12), do: :operador
end
