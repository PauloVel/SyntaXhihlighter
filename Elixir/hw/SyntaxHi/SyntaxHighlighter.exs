defmodule Hw.SyntaxHighlighter do
  # Resaltador de C++
  @cpp_keywords [
    "int", "float", "double", "char", "void", "bool",
    "if", "else", "while", "for", "return", "class",
    "struct", "public", "private", "protected",
    "namespace", "using", "include", "main", "std", "cout", "endl"
  ]

  # Columnas: 0=espacio, 1=letras/_, 2=num, 3=/, 4=*, 5=", 6=#, 7=ops, 8=delims, 9=desconocido
  @tabla_estados [
    [0, 1, 2, 3, 7, 5, 6, 7, 16, 18],        # Estado 0: Inicio
    [10, 1, 1, 10, 10, 10, 10, 10, 10, 10],  # Estado 1
    [11, 11, 2, 11, 11, 11, 11, 11, 11, 11], # Estado 2: Números (acepta letras/X para hex)
    [12, 12, 12, 4, 8, 12, 12, 12, 12, 12],  # Estado 3: Diagonal / oper / comentarios
    [4, 4, 4, 4, 4, 4, 4, 4, 4, 4],          # Estado 4: Comentario de una línea (//)
    [5, 5, 5, 5, 5, 14, 5, 5, 5, 5],         # Estado 5: Dentro de un String " "
    [15, 6, 15, 15, 15, 15, 15, 15, 15, 15], # Estado 6: Preprocesador #
    [12, 12, 12, 12, 12, 12, 12, 7, 12, 12], # Estado 7: Operadores
    [8, 8, 8, 8, 9, 8, 8, 8, 8, 8],          # Estado 8: Dentro de comentario /*
    [8, 8, 8, 13, 9, 8, 8, 8, 8, 8]          # Estado 9: Posible salida de */
  ]

  @letras "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ_xX"
  @numeros "0123456789abcdefABCDEF"
  @operadores "+-*%=<>!&|^~:"
  @delimitadores "()[]{},;."

  defp siguiente_estado(estado_actual, columna) do
    if estado_actual < 10 do
      @tabla_estados |> Enum.at(estado_actual) |> Enum.at(columna)
    else
      18
    end
  end

  defp clasificar_letra(letra) do
    cond do
      letra in [" ", "\t", "\r", "\n"] -> 0
      String.contains?(@letras, letra) -> 1
      String.contains?(@numeros, letra) -> 2
      letra == "/" -> 3
      letra == "*" -> 4
      letra == "\"" -> 5
      letra == "#" -> 6
      String.contains?(@operadores, letra) -> 7
      String.contains?(@delimitadores, letra) -> 8
      true -> 9
    end
  end

  defp wrapping_html(estado, lexema) do
    case estado do
      e when e in [10, 1] ->
        if Enum.member?(@cpp_keywords, lexema) do
          "<span class=\"keyword\">#{lexema}</span>"
        else
          "<span class=\"identifier\">#{lexema}</span>"
        end
      e when e in [11, 2] -> "<span class=\"number\">#{lexema}</span>"
      e when e in [12, 3, 7] -> "<span class=\"operator\">#{lexema}</span>"
      e when e in [13, 4, 8, 9] -> "<span class=\"comment\">#{lexema}</span>"
      e when e in [14, 5] -> "<span class=\"string\">#{lexema}</span>"
      e when e in [15, 6] -> "<span class=\"preprocessor\">#{lexema}</span>"
      16 -> "<span class=\"delimiter\">#{lexema}</span>"
      18 -> "<span class=\"error\">#{lexema}</span>"
      _ -> ""
    end
  end

  # Al acabar la línea, si estamos en estado de comentario multilinea o string NO cerramos el token
  defp correr_linea([], estado, lexema, html_acumulado) do
    cond do
      estado in [5, 8, 9] -> {html_acumulado, estado, lexema}
      lexema != "" -> {html_acumulado <> wrapping_html(estado, lexema), 0, ""}
      true -> {html_acumulado, 0, ""}
    end
  end

  defp correr_linea([char | cola], estado, lexema, html_acumulado) do
    columna = clasificar_letra(char)
    nuevo_estado = siguiente_estado(estado, columna)

    cond do
      # Seguimos dentro del string
      estado == 5 && nuevo_estado != 14 ->
        correr_linea(cola, 5, lexema <> char, html_acumulado)

      # Seguimos dentro del comentario multilinea
      estado == 8 && nuevo_estado != 9 ->
        correr_linea(cola, 8, lexema <> char, html_acumulado)

      nuevo_estado == 14 ->
        token_listo = wrapping_html(14, lexema <> char)
        correr_linea(cola, 0, "", html_acumulado <> token_listo)

      # Si encontramos un estado final normal
      nuevo_estado >= 10 ->
        token_listo = wrapping_html(nuevo_estado, lexema)
        col_fresh = clasificar_letra(char)
        est_fresh = siguiente_estado(0, col_fresh)

        if est_fresh == 0 do
          correr_linea(cola, 0, "", html_acumulado <> token_listo <> char)
        else
          correr_linea(cola, est_fresh, char, html_acumulado <> token_listo)
        end

      # Espacios o saltos vacíos
      nuevo_estado == 0 ->
        correr_linea(cola, 0, "", html_acumulado <> lexema <> char)

      true ->
        correr_linea(cola, nuevo_estado, lexema <> char, html_acumulado)
    end
  end

  # Procesamos manteniendo el estado entre líneas
  defp procesar_todo([], _estado, _lexema, html_acumulado), do: html_acumulado
  defp procesar_todo([renglon | cola], estado_anterior, lexema_anterior, html_acumulado) do
    letras = String.graphemes(renglon)

    # Mandamos el estado en el que se quedó la línea pasada
    {html_de_linea, nuevo_estado, nuevo_lexema} = correr_linea(letras, estado_anterior, lexema_anterior, "")

    # Si saltamos de renglón y seguimos en comentario o string, metemos el salto de línea adentro del lexema
    {enviar_estado, enviar_lexema} =
      if nuevo_estado in [5, 8], do: {nuevo_estado, nuevo_lexema <> "\n"}, else: {nuevo_estado, nuevo_lexema}

    procesar_todo(cola, enviar_estado, enviar_lexema, html_acumulado <> html_de_linea <> (if nuevo_estado in [5, 8], do: "", else: "\n"))
  end

  def highlight_file(archivo_entrada, archivo_salida) do
    lineas =
      archivo_entrada
      |> File.stream!()
      |> Enum.map(&String.trim_trailing/1)

    # Arrancamos desde estado 0 y buffer vacío ""
    html_puro = procesar_todo(lineas, 0, "", "")

    plantilla = File.read!("SyntaxHi/sample.html")
    html_final = String.replace(plantilla, "{{result}}", html_puro)

    File.write!("SyntaxHi/" <> archivo_salida, html_final)
    IO.puts("Exito")
  end
end
