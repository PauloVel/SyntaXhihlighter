defmodule Hw.SyntaxHighlighterPro do
  # Resaltador de C++ para la Evidencia 2.
  # Lee archivos .cpp/.h de un directorio y genera HTML resaltado.
  # Tiene modo secuencial, paralelo y benchmark.

  # palabras reservadas que usamos en clase / ejemplos
  @cpp_keywords MapSet.new([
    "int", "float", "double", "char", "void", "bool", "string",
    "if", "else", "while", "for", "return", "break", "continue",
    "class", "struct", "public", "private", "protected",
    "namespace", "using", "template", "typename", "const", "auto",
    "nullptr", "true", "false", "new", "delete", "static", "virtual",
    "operator", "sizeof", "switch", "case", "default", "try", "catch", "throw"
  ])

  @cpp_operators MapSet.new([
    "+", "-", "*", "/", "%", "++", "--",
    "=", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<=", ">>=",
    "==", "!=", "<", ">", "<=", ">=",
    "&&", "||", "!",
    "&", "|", "^", "~",
    "<<", ">>", "->", "::", ".", "->*", ".*",
    ":", "?", "..."
  ])

  @operator_starters "+-*/%=<>!&|^~:?"
  @delimiters "()[]{},;"
  @digits "0123456789"
  @letters "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @hex_letters "abcdefABCDEF"

  # escapar caracteres especiales de HTML

  defp html_escape(text) do
    text
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
    |> String.replace("'", "&#39;")
  end

  # poner cada token en un span con su clase

  defp wrap_token(type, lexeme) do
    safe = html_escape(lexeme)
    "<span class=\"#{type}\">#{safe}</span>"
  end

  defp emit_token(:space, char), do: char
  defp emit_token(type, lexeme), do: wrap_token(type, lexeme)

  # clasificar cada caracter

  defp char_class(char) do
    cond do
      char in [" ", "\t", "\r", "\n"]          -> :space
      char == "_" or letter?(char)               -> :letter
      digit?(char)                                -> :digit
      char == "."                                 -> :dot
      char == "/"                                 -> :slash
      char == "*"                                 -> :star
      char == "\""                                -> :dquote
      char == "'"                                 -> :squote
      char == "#"                                 -> :hash
      String.contains?(@operator_starters, char)  -> :operator
      String.contains?(@delimiters, char)         -> :delimiter
      true                                        -> :other
    end
  end

  defp letter?(char), do: String.contains?(@letters, char)
  defp digit?(char), do: String.contains?(@digits, char)
  defp hex_letter?(char), do: String.contains?(@hex_letters, char)

  # maquina de estados

  defp tokenize([], state, lexeme, output) do
    if state in [:comment_block, :comment_block_star, :string, :string_esc, :char, :char_esc] do
      {output, state, lexeme}
    else
      {output <> emit_token(final_type(state), lexeme), :start, ""}
    end
  end

  defp tokenize([c | rest], :start, "", output) when c in [" ", "\t", "\r"] do
    tokenize(rest, :start, "", output <> c)
  end

  defp tokenize(["\n" | rest], :start, "", output) do
    tokenize(rest, :start, "", output <> "\n")
  end

  defp tokenize([c | rest], :start, "", output) do
    case char_class(c) do
      :letter     -> tokenize(rest, :id, c, output)
      :digit      -> tokenize(rest, :number, c, output)
      :dquote     -> tokenize(rest, :string, c, output)
      :squote     -> tokenize(rest, :char, c, output)
      :hash       -> tokenize(rest, :preprocessor, c, output)
      :delimiter  -> tokenize(rest, :start, "", output <> wrap_token(:delimiter, c))
      :operator   -> tokenize(rest, :operator, c, output)
      :dot        -> handle_dot_start(rest, output)
      :slash      -> handle_slash_start(rest, output)
      :other      -> tokenize(rest, :start, "", output <> wrap_token(:error, c))
      _           -> tokenize(rest, :start, "", output <> c)
    end
  end

  # Identificadores.
  defp tokenize([c | rest], :id, lexeme, output) do
    if c == "_" or digit?(c) or letter?(c) do
      tokenize(rest, :id, lexeme <> c, output)
    else
      type = if MapSet.member?(@cpp_keywords, lexeme), do: :keyword, else: :identifier
      finalize_and_continue([c | rest], type, lexeme, output)
    end
  end

  # Números enteros.
  defp tokenize([c | rest], :number, lexeme, output) do
    cond do
      digit?(c) -> tokenize(rest, :number, lexeme <> c, output)
      c == "x" and lexeme == "0" -> tokenize(rest, :number_hex, "0x", output)
      c == "X" and lexeme == "0" -> tokenize(rest, :number_hex, "0X", output)
      c == "." -> tokenize(rest, :number_float, lexeme <> ".", output)
      true -> finalize_and_continue([c | rest], :number, lexeme, output)
    end
  end

  # Números hexadecimales.
  defp tokenize([c | rest], :number_hex, lexeme, output) do
    if digit?(c) or hex_letter?(c) do
      tokenize(rest, :number_hex, lexeme <> c, output)
    else
      finalize_and_continue([c | rest], :number, lexeme, output)
    end
  end

  # Números decimales con punto.
  defp tokenize([c | rest], :number_float, lexeme, output) do
    if digit?(c) do
      tokenize(rest, :number_float, lexeme <> c, output)
    else
      finalize_and_continue([c | rest], :number, lexeme, output)
    end
  end

  # Cadenas de texto.
  defp tokenize(["\\" | rest], :string, lexeme, output) do
    tokenize(rest, :string_esc, lexeme <> "\\", output)
  end

  defp tokenize(["\"" | rest], :string, lexeme, output) do
    tokenize(rest, :start, "", output <> wrap_token(:string, lexeme <> "\""))
  end

  defp tokenize([c | rest], :string, lexeme, output) do
    tokenize(rest, :string, lexeme <> c, output)
  end

  defp tokenize([c | rest], :string_esc, lexeme, output) do
    tokenize(rest, :string, lexeme <> c, output)
  end

  # Caracteres.
  defp tokenize(["\\" | rest], :char, lexeme, output) do
    tokenize(rest, :char_esc, lexeme <> "\\", output)
  end

  defp tokenize(["'" | rest], :char, lexeme, output) do
    tokenize(rest, :start, "", output <> wrap_token(:string, lexeme <> "'"))
  end

  defp tokenize([c | rest], :char, lexeme, output) do
    tokenize(rest, :char, lexeme <> c, output)
  end

  defp tokenize([c | rest], :char_esc, lexeme, output) do
    tokenize(rest, :char, lexeme <> c, output)
  end

  # Comentarios de una línea.
  defp tokenize(["\n" | rest], :comment_line, lexeme, output) do
    tokenize(rest, :start, "", output <> wrap_token(:comment, lexeme) <> "\n")
  end

  defp tokenize([c | rest], :comment_line, lexeme, output) do
    tokenize(rest, :comment_line, lexeme <> c, output)
  end

  # Comentarios multilínea.
  defp tokenize(["*" | rest], :comment_block, lexeme, output) do
    tokenize(rest, :comment_block_star, lexeme <> "*", output)
  end

  defp tokenize([c | rest], :comment_block, lexeme, output) do
    tokenize(rest, :comment_block, lexeme <> c, output)
  end

  defp tokenize(["/" | rest], :comment_block_star, lexeme, output) do
    tokenize(rest, :start, "", output <> wrap_token(:comment, lexeme <> "/"))
  end

  defp tokenize(["*" | rest], :comment_block_star, lexeme, output) do
    tokenize(rest, :comment_block_star, lexeme <> "*", output)
  end

  defp tokenize([c | rest], :comment_block_star, lexeme, output) do
    tokenize(rest, :comment_block, lexeme <> c, output)
  end

  # Preprocesador.
  defp tokenize(["\n" | rest], :preprocessor, lexeme, output) do
    tokenize(rest, :start, "", output <> wrap_token(:preprocessor, lexeme) <> "\n")
  end

  defp tokenize([c | rest], :preprocessor, lexeme, output) do
    tokenize(rest, :preprocessor, lexeme <> c, output)
  end

  # Operadores.
  defp tokenize(["." | rest], :operator, "..", output) do
    tokenize(rest, :operator, "...", output)
  end

  defp tokenize(["." | rest], :operator, ".", output) do
    tokenize(rest, :operator, "..", output)
  end

  defp tokenize([c | rest], :operator, lexeme, output) do
    combined = lexeme <> c

    if MapSet.member?(@cpp_operators, combined) do
      tokenize(rest, :operator, combined, output)
    else
      finalize_and_continue([c | rest], :operator, lexeme, output)
    end
  end

  # '.' puede ser numero o operador; '/' puede ser operador o comentario

  defp handle_dot_start([], output) do
    tokenize([], :operator, ".", output)
  end

  defp handle_dot_start([c | rest], output) do
    if digit?(c) do
      tokenize(rest, :number_float, "." <> c, output)
    else
      tokenize([c | rest], :operator, ".", output)
    end
  end

  defp handle_slash_start([], output) do
    tokenize([], :start, "", output <> wrap_token(:operator, "/"))
  end

  defp handle_slash_start(["/" | rest], output) do
    tokenize(rest, :comment_line, "//", output)
  end

  defp handle_slash_start(["*" | rest], output) do
    tokenize(rest, :comment_block, "/*", output)
  end

  defp handle_slash_start(chars, output) do
    tokenize(chars, :operator, "/", output)
  end

  # auxiliares

  defp finalize_and_continue(chars, type, lexeme, output) do
    tokenize(chars, :start, "", output <> emit_token(type, lexeme))
  end

  defp final_type(:id), do: :identifier
  defp final_type(:number), do: :number
  defp final_type(:number_float), do: :number
  defp final_type(:number_hex), do: :number
  defp final_type(:operator), do: :operator
  defp final_type(:preprocessor), do: :preprocessor
  defp final_type(:comment_line), do: :comment
  defp final_type(:comment_block), do: :comment
  defp final_type(:comment_block_star), do: :comment
  defp final_type(:string), do: :string
  defp final_type(:char), do: :string
  defp final_type(_), do: :error

  # recorrer lineas conservando estado (para comentarios/strings multilinea)

  defp process_lines([], _state, _lexeme, output), do: output

  defp process_lines([line | rest], state, lexeme, output) do
    chars = String.graphemes(line)
    {new_output, new_state, new_lexeme} = tokenize(chars, state, lexeme, output)

    if new_state in [:comment_block, :comment_block_star, :string, :string_esc, :char, :char_esc] do
      process_lines(rest, new_state, new_lexeme <> "\n", new_output)
    else
      process_lines(rest, :start, "", new_output <> "\n")
    end
  end

  # generar HTML de todo el archivo

  def highlight_content(content, template) do
    lines =
      content
      |> String.split("\n")
      |> Enum.map(&String.trim_trailing/1)

    body = process_lines(lines, :start, "", "")
    String.replace(template, "{{result}}", body)
  end

  # procesar directorios

  defp find_source_files(input_dir) do
    cpp =
      input_dir
      |> Path.join("*.cpp")
      |> Path.wildcard()

    h =
      input_dir
      |> Path.join("*.h")
      |> Path.wildcard()

    Enum.sort(cpp ++ h)
  end

  defp output_path(input_file, output_dir) do
    base = Path.rootname(Path.basename(input_file)) <> ".html"
    Path.join(output_dir, base)
  end

  def process_file(input_file, output_file, template) do
    content = File.read!(input_file)
    html = highlight_content(content, template)
    File.write!(output_file, html)
    byte_size(html)
  end

  def process_sequential(files, output_dir, template) do
    Enum.each(files, fn file ->
      out = output_path(file, output_dir)
      process_file(file, out, template)
    end)
  end

  def process_parallel(files, output_dir, template) do
    files
    |> Task.async_stream(fn file ->
      out = output_path(file, output_dir)
      process_file(file, out, template)
    end, max_concurrency: System.schedulers_online(), ordered: false)
    |> Stream.run()
  end

  def benchmark(files, output_dir, template, runs \\ 5) do
    IO.puts("Benchmark: #{runs} corridas de cada version...\n")

    {seq_times, par_times} =
      Enum.reduce(1..runs, {[], []}, fn _, {seq_acc, par_acc} ->
        {seq_us, _} = :timer.tc(fn -> process_sequential(files, output_dir, template) end)
        {par_us, _} = :timer.tc(fn -> process_parallel(files, output_dir, template) end)
        {[seq_us | seq_acc], [par_us | par_acc]}
      end)

    avg_seq = Enum.sum(seq_times) / length(seq_times)
    avg_par = Enum.sum(par_times) / length(par_times)
    speedup = if avg_par > 0, do: avg_seq / avg_par, else: 0.0

    IO.puts("Archivos: #{length(files)}")
    IO.puts("Secuencial promedio: #{Float.round(avg_seq / 1000, 3)} ms")
    IO.puts("Paralelo promedio:   #{Float.round(avg_par / 1000, 3)} ms")
    IO.puts("Speedup:             #{Float.round(speedup, 2)}x\n")
  end

  def run(input_dir, output_dir, mode) do
    File.mkdir_p!(output_dir)
    files = find_source_files(input_dir)
    script_dir = Path.dirname(Path.absname(__ENV__.file))
    template = File.read!(Path.join(script_dir, "sample.html"))

    case mode do
      "sequential" ->
        process_sequential(files, output_dir, template)
        IO.puts("Modo secuencial: procesados #{length(files)} archivos en '#{output_dir}'.")

      "parallel" ->
        process_parallel(files, output_dir, template)
        IO.puts("Modo paralelo: procesados #{length(files)} archivos en '#{output_dir}'.")

      "benchmark" ->
        benchmark(files, output_dir, template)
        IO.puts("Benchmark completado. Los archivos finales corresponden a la última ejecución paralela.")

      _ ->
        IO.puts("Error: modo '#{mode}' no válido.")
        IO.puts("Uso: elixir SyntaxHighlighterPro.exs <input_dir> <output_dir> [sequential|parallel|benchmark]")
    end
  end
end

# CLI

case System.argv() do
  ["-h"] ->
    IO.puts("Uso: elixir SyntaxHighlighterPro.exs <input_dir> <output_dir> [sequential|parallel|benchmark]")

  ["--help"] ->
    IO.puts("Uso: elixir SyntaxHighlighterPro.exs <input_dir> <output_dir> [sequential|parallel|benchmark]")

  [input_dir, output_dir] ->
    Hw.SyntaxHighlighterPro.run(input_dir, output_dir, "benchmark")

  [input_dir, output_dir, mode] ->
    Hw.SyntaxHighlighterPro.run(input_dir, output_dir, mode)

  _ ->
    IO.puts("Uso: elixir SyntaxHighlighterPro.exs <input_dir> <output_dir> [sequential|parallel|benchmark]")
end
