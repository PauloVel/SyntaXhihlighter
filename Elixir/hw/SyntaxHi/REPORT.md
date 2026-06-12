# Evidence 2 — Parallel Syntax Highlighter
**TC2037 · Implementation of Computational Methods**

---

## 1. Overview

This report documents the extension of the C++ syntax highlighter developed in Evidence 1. The program was refactored and extended in two directions:

1. **Sequential version** — processes all source files in a directory one at a time.
2. **Parallel version** — processes all source files concurrently, assigning one Elixir task per file and distributing them across available CPU schedulers.

Both versions share the same core tokenizer, which is implemented as a finite automaton (FSM) using Elixir pattern matching and recursion.

---

## 2. Solution Design

### 2.1 Core Algorithm — DFA Tokenizer

The tokenizer is a **Finite State Machine** encoded with Elixir function clauses and `cond` expressions. Each character is classified into a column (letter, digit, operator, delimiter, etc.) and the current state determines whether to continue accumulating the lexeme or finalize it. When a token ends, the accumulated lexeme is wrapped in the appropriate HTML `<span>` tag and the automaton resets.

States carry across line boundaries to correctly handle multi-line block comments (`/* … */`) and string literals.

### 2.2 Sequential Version

```elixir
def process_sequential(files, output_dir, template) do
  Enum.each(files, fn file ->
    out = output_path(file, output_dir)
    process_file(file, out, template)
  end)
end
```

Files are processed in order using `Enum.each/2`. Each call to `process_file/3` is blocking — the next file starts only after the current one finishes.

### 2.3 Parallel Version

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

`Task.async_stream/3` spawns one lightweight Elixir process per file. The `max_concurrency` is set to `System.schedulers_online()`, which matches the number of logical CPU cores available to the BEAM scheduler. `ordered: false` allows results to be collected as soon as each task finishes rather than waiting for the order of the input list.

---

## 3. Bugs Fixed from Evidence 1

| # | Bug | Fix |
|---|-----|-----|
| 1 | Hardcoded `"SyntaxHi/"` path prefix | Paths are now built dynamically from arguments using `Path.join/2` |
| 2 | Hardcoded template path | Template is loaded from `sample.html` using `Path.dirname(Path.absname(__ENV__.file))`, so the script works regardless of the current working directory |
| 3 | Delimiters misclassified as errors | Rewrote the FSM transitions so that parentheses, braces, brackets, etc. are correctly classified as `delimiter` instead of `error` |
| 4 | Regex per character for letter classification | Replaced by `String.contains?(@letters, char)`, which is faster than compiling and matching a regex on every character |

---

## 4. Benchmark Results

Benchmarks were run on the author's machine processing 8 sample C++ files. Each version was measured 5 times using `:timer.tc/1` and the average was computed. Runs were interleaved (sequential, parallel, sequential, parallel, …) so both versions benefit equally from operating-system caching.

> **Machine specs:** *(add your CPU / RAM / OS here)*

| Version     | Average (ms) | Minimum (ms) | Maximum (ms) |
|-------------|--------------|--------------|--------------|
| Sequential  | 135.844      | 116.989      | 166.558      |
| Parallel    | 89.689       | 78.952       | 123.128      |

**Speedup = 135.844 / 89.689 ≈ 1.51×**

The parallel version is consistently faster, although the speedup is below the theoretical maximum because file I/O and task scheduling overhead partially serialize the workload, especially for small files.

---

## 5. Time Complexity Analysis

Let:
- **N** = total number of characters across all input files
- **F** = number of files
- **P** = number of parallel schedulers (CPU cores)

### 5.1 Per-character work

`classify_char/1` performs a fixed number of `String.contains?` checks, each O(|alphabet|) ≈ O(1) since all character sets have constant size. `next_state/2` performs two `Enum.at/2` accesses on constant-size lists — O(1). `wrap_html/2` is a constant-time pattern match and string interpolation.

Therefore, processing a single character is **O(1)**.

### 5.2 Per-file work

Processing a file with `n` characters involves iterating over all `n` graphemes once. The DFA never backtracks (each character is consumed exactly once). Total per-file complexity: **O(n)**.

### 5.3 Sequential version

All F files are processed one after another:

```
T_seq = O(n₁) + O(n₂) + … + O(nF) = O(N)
```

where N = Σ nᵢ is the total character count. The sequential version is **O(N)**.

### 5.4 Parallel version

With P schedulers and F files distributed across them, assuming roughly equal file sizes (n̄ = N/F):

```
T_par ≈ O(N / P)   (ideal)
```

In practice, task spawning, scheduling overhead, and I/O contention reduce the ideal speedup, giving:

```
Speedup = T_seq / T_par ≈ P   (bounded by Amdahl's Law)
```

Since file I/O is the dominant cost for small files, the actual speedup observed (~2×) is lower than the theoretical maximum (~20×) on a 20-thread machine, because disk access serializes partially even when CPU work is parallel.

### 5.5 Summary table

| Version    | Time complexity | Space complexity |
|------------|-----------------|------------------|
| Sequential | O(N)            | O(n_max)         |
| Parallel   | O(N / P)        | O(n_max · P)     |

Space is O(n_max) per file since only one file's HTML is held in memory at a time per process. The parallel version holds up to P such buffers simultaneously.

---

## 6. Reflection on Ethical Implications

Parallel computing and automated code analysis tools, such as the syntax highlighter built in this evidence, are foundational to modern software development infrastructure. Their societal implications are worth examining:

**Accessibility and equity.** Developer tools that run faster and more efficiently lower the barrier to entry for software development. IDEs and code editors that leverage parallel highlighting, linting, and autocompletion make programming more accessible to students and developers working on lower-end hardware. However, if such tools are proprietary or paywalled, they can deepen the divide between well-funded and under-resourced developers.

**Environmental cost of parallelism.** Exploiting multi-core CPUs increases instantaneous power consumption. At scale — for example, cloud-based CI/CD systems that run millions of parallel jobs per day — the aggregate energy cost is significant. Engineers have an ethical responsibility to design parallel systems that are efficient not only in time but also in energy use.

**Automation and labor.** Tools that automate code processing tasks (highlighting, formatting, linting, and increasingly, generation) can displace certain categories of software work. While they also amplify developer productivity, it is important for the industry to consider how to retrain and support workers whose roles are displaced by automation.

**Correctness and trust.** A syntax highlighter that misclassifies tokens can mislead developers into misreading their own code. At a larger scale, automated analysis tools that produce incorrect results — particularly in security-sensitive contexts — can introduce subtle vulnerabilities. Verifying the correctness of computational tools is therefore an ethical obligation, not merely a technical one.

In conclusion, the design and deployment of parallel computational tools must be guided not only by performance objectives but also by considerations of fairness, environmental responsibility, and the broader societal impact of automation.

---

## 7. File Structure

```
SyntaxHi/
├── SyntaxHighlighterPro.exs   # Main program (sequential + parallel + benchmark)
├── sample.html                # HTML/CSS template
├── REPORT.md                  # This report
├── example1.cpp               # Sample C++ source files
├── example2.cpp
├── example3.cpp
├── bst.cpp
├── linked_list.cpp
├── matrix.cpp
├── sorting.cpp
└── strings.cpp
```

## 8. Usage

From the project directory:

```bash
cd "/mnt/c/Users/paulo/OneDrive/Desktop/Semestre4/TC2037-202611/Elixir/hw/SyntaxHi"
elixir SyntaxHighlighterPro.exs . ./html_output benchmark
```

The CLI accepts an input directory, an output directory, and an optional mode:

```bash
elixir SyntaxHighlighterPro.exs <input_dir> <output_dir> [sequential|parallel|benchmark]
```

- `sequential` — processes all `.cpp` and `.h` files one at a time.
- `parallel` — processes all source files concurrently with `Task.async_stream` (`ordered: false`).
- `benchmark` (default) — runs both versions 5 times interleaved and reports average, min, max, and speedup.

Example:

```bash
# Process all sources in the current folder sequentially
elixir SyntaxHighlighterPro.exs . ./html_output sequential

# Process all sources in parallel
elixir SyntaxHighlighterPro.exs . ./html_output parallel

# Run benchmark
elixir SyntaxHighlighterPro.exs . ./html_output benchmark
```
