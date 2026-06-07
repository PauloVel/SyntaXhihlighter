# Parallelism – Problems 2 & 3

**Elixir File:** `parallelism.exs`

## How to run

```bash
elixir parallelism.exs
```

## Problems

### 2 · Sum of primes ≤ n
Checks primality with trial division up to `⌈√x⌉`. The parallel version splits the range into chunks (one per scheduler) and runs each in a `Task.async/await`.

### 3 · Pi via numerical integration
Uses the rectangle (midpoint) method over `n` intervals. The parallel version divides the interval indices across tasks and sums the partial results.

## Timing

Use `:timer.tc` to measure (returns microseconds):

```elixir
:timer.tc(fn -> Parallelism.sum_primes_parallel(500_000) end) |> elem(0) |> Kernel./(1_000_000)
```

## Speedup results

Measured in my computer. Averaged over 3 runs. Formula: **Sp = T₁ / Tp**

| Problem | n | Sequential (avg) | Parallel (avg) | Speedup (avg) |
|---------|---|-----------------|----------------|---------------|
| Sum of primes | 200,000 | ~350 ms | ~75 ms | **~4.88×** |
| Pi approximation | 10,000,000 | ~709 ms | ~85 ms | **~8.40×** |

Individual runs:

| Run | Primes seq | Primes par | Primes Sp | Pi seq | Pi par | Pi Sp |
|-----|-----------|-----------|-----------|--------|--------|-------|
| 1 | 364 ms | 99 ms | 3.67× | 713 ms | 76 ms | 9.38× |
| 2 | 330 ms | 69 ms | 4.81× | 705 ms | 93 ms | 7.56× |
| 3 | 359 ms | 58 ms | 6.15× | 709 ms | 86 ms | 8.25× |

Speedup variance in the primes problem is due to OS scheduler variability when spawning 20 tasks for a CPU-bound workload. Pi approximation is more stable since each task does uniform floating-point work.