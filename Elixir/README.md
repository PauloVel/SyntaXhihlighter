# Elixir
Programs to learn Elixir

## Language references
- https://elixir-lang.org/getting-started/introduction.html
- https://joyofelixir.com/toc.html
- https://learnxinyminutes.com/docs/elixir/
- https://serokell.io/blog/learn-elixir
- https://stackoverflow.com/questions/50496783/extract-the-second-element-of-a-tuple-in-a-pipeline
- https://subscription.packtpub.com/book/application-development/9781788472678/1/ch01lvl1sec14/functions-and-modules
- https://pragprog.com/titles/jgotp/designing-elixir-systems-with-otp/

### fn vs def
- https://stackoverflow.com/questions/18011784/why-are-there-two-kinds-of-functions-in-elixir?rq=1

### The `for` statement
- https://hashrocket.com/blog/posts/elixir-for-loops-go-beyond-comprehension

### Graphics libraries
- https://github.com/milmazz/turtle
- https://medium.com/@giandr/elixir-scenic-snake-game-b8616b1d7ee0
    ```
    sudo apt-get install pkgconf libglfw3 libglfw3-dev libglewmx1.13 libglew-dev
    ```

### Style guide
- https://github.com/christopheradams/elixir_style_guide

## Runing examples
There are multiple ways to run Elixir programs
1. Save the files as .exs, then run with a command like:
```bash
elixir example.exs
```
2. Save files as .exs, then enter interactive mode with the file:
```bash
iex example.exs
```
then call the functions from the Elixir shell.

To reload the file, use the `c` function:
```elixir
iex> c("example.exs")
```

## Defining functions
**Lambda functions:**
```elixir
greet = fn (name) -> IO.puts "Hello #{name}!" end
```

Capture notation, where arguments are refered to as `&n`
```elixir
greet = &(IO.puts "Hello #{&1}!")
```

To call lambda functions, use a dot:
```elixir
greet.("Gil")
```

**Named functions:**
Must go inside modules:
```elixir
defmodule Multiply do
  def mult(_, 0), do: 0
  def mult(a, b), do: a + mult(a, b - 1)
end
```

Called with the module name:
```elixir
Multiply.mult(6, 2)
```

## Tracing function calls

### Using the `binding` function
Add the following code inside a function:
```elixir
IO.inspect binding()
```

### Using the dbg package

Follow the instructions at:
- https://stackoverflow.com/questions/50364530/elixir-trace-function-call
- https://kaiwern.com/posts/2020/11/02/debugging-with-tracing-in-elixir/

The steps:
```elixir
:dbg.start
:dbg.tracer
:dbg.p(:all, :c)
:dbg.tpl(Fact, :fact, 1, [{:_, [], [{:return_trace}]}])
:dbg.tpl(Fact, :do_tail_fact, 2, [{:_, [], [{:return_trace}]}])

:dbg.stop_clear
```


## Testing with mix
Selecting the tests to be executed / skipped
- https://stackoverflow.com/questions/26150146/how-can-i-make-mix-run-only-specific-tests-from-my-suite-of-tests

## Tools to use Elixir
- Add ons for vim:
    https://bitboxer.de/2016/11/13/vim-for-elixir/

- To keep the command history in **iex**, add this line to .bashrc
```bash
export ERL_AFLAGS="-kernel shell_history enabled"
```


## Video courses

- https://www.youtube.com/watch?v=TWt-3I77OM0&list=PLTd5ehIj0goPm2HGj-YVy-IlIfBXDL9NC
- https://www.youtube.com/watch?v=Q0Z1jqv6LW0&list=PLbV6TI03ZWYVQEC_Txq_cV0Uy_s16b0d3
