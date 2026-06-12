# Evidence 2 — Parallel Syntax Highlighter
**TC2037 · Implementation of Computational Methods**

---

## 1. What the program does

This is an extension of the C++ syntax highlighter from Evidence 1. Now it can process several files at once:

- **Sequential mode**: reads each `.cpp`/`.h` file one by one and writes the highlighted HTML.
- **Parallel mode**: uses `Task.async_stream` to process many files at the same time, taking advantage of multiple CPU cores.
- **Benchmark mode**: runs both versions several times and compares their average execution time.

The tokenizer is the same finite-state machine from before, but now it is applied to a whole directory instead of a single file.

---

## 2. How it works

### 2.1 Tokenizer

The tokenizer walks through each character of the file and keeps a state (`:start`, `:id`, `:number`, `:string`, `:comment_block`, etc.). When the current character cannot continue the token, the lexeme is wrapped in an HTML `<span>` with the right CSS class and the state resets. Multi-line comments and strings work because the state is carried from one line to the next.

### 2.2 Sequential version

```elixir
def process_sequential(files, output_dir, template) do
  Enum.each(files, fn file ->
    out = output_path(file, output_dir)
    process_file(file, out, template)
  end)
end
```

Files are processed with `Enum.each/2`, so each file finishes before the next one starts.

### 2.3 Parallel version

```elixir
def process_parallel(files, output_dir, template) do
  files
  |> Task.async_stream(fn file ->
      out = output_path(file, output_dir)
      process_file(file, out, template)
    end,
    max_concurrency: System.schedulers_online(),
    ordered: false
  )
  |> Stream.run()
end
```

`Task.async_stream` creates one lightweight Elixir process per file. `max_concurrency` is set to the number of CPU cores, and `ordered: false` lets results come out as soon as each task finishes, which improves performance when files have different sizes.

---

## 3. Problems fixed from Evidence 1

| # | Problem | Fix |
|---|---------|-----|
| 1 | Paths were hardcoded | Now paths come from CLI arguments |
| 2 | Template path depended on current directory | Now loaded with `Path.dirname(Path.absname(__ENV__.file))` |
| 3 | Delimiters were marked as errors | Rewrote the FSM so `()`, `{}`, `[]`, etc. are `delimiter` |
| 4 | Used a regex to check every letter | Replaced it with `String.contains?(@letters, char)` |

---

## 4. Benchmark results

I ran the benchmark on my machine with the 8 sample files. Each version ran 5 times, alternating sequential and parallel runs.

> **Machine specs:** *(add your CPU / RAM / OS here)*

| Version | Average time (ms) |
|---------|-------------------|
| Sequential | 135.844 |
| Parallel | 89.689 |

**Speedup = 135.844 / 89.689 ≈ 1.51×**

The parallel version is faster, but the speedup is not huge because file I/O and task creation add some overhead. With bigger files the speedup would probably be larger.

---

## 5. Complexity analysis

Let **N** be the total number of characters in all files and **P** the number of CPU cores.

- **Per character**: the work is constant (a few comparisons and a `MapSet` lookup), so it is **O(1)**.
- **Per file**: each character is visited once, so it is **O(n)** for a file with `n` characters.
- **Sequential version**: all files are processed one after another, so the total time is **O(N)**.
- **Parallel version**: the work is divided among `P` cores, so the theoretical time is **O(N / P)**. In practice it is less because of I/O and scheduling overhead.

This matches the benchmark: the parallel time is lower but not exactly `N / P` because of the overhead mentioned above.

---

## 6. Reflection

Parallel tools like this one are useful because they save time when processing many files, but they also have social implications.

- **Accessibility**: faster tools help students and people with older computers. But if good tools are expensive or closed-source, they can create inequality.
- **Energy**: running many cores at once uses more power. At large scale (cloud servers, CI/CD) this matters for the environment, so we should write efficient code.
- **Trust**: if a highlighter misclassifies code, it can confuse the programmer. Automated tools need to be tested and reliable, especially in security-related contexts.

In general, performance is important, but it should not be the only goal. Tools should also be fair, efficient, and trustworthy.

---

## 7. Files

```
SyntaxHi/
├── SyntaxHighlighterPro.exs   # main program
├── sample.html                # CSS template
├── REPORT.md                  # this report
├── example1.cpp               # sample C++ files
├── example2.cpp
├── example3.cpp
├── bst.cpp
├── linked_list.cpp
├── matrix.cpp
├── sorting.cpp
└── strings.cpp
```

## 8. How to run it

```bash
cd "/mnt/c/Users/paulo/OneDrive/Desktop/Semestre4/TC2037-202611/Elixir/hw/SyntaxHi"
elixir SyntaxHighlighterPro.exs . ./html_output benchmark
```

Modes:

- `sequential` — one file at a time
- `parallel` — all files in parallel
- `benchmark` — runs both and shows the speedup (default)
