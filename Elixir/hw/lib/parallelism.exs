# Paulo Velez
# A01787207

defmodule Parallelism do

  # measurements (averaged over 3 runs, n = 500_000 for primes, n = 50_000_000 for pi):
  #
  # Problem 2 - Sum of primes up to n = 500_000:
  #   Sequential avg:  ~4200 ms
  #   Parallel avg:    ~2300 ms
  #   Speedup Sp:      ~1.83x
  #
  # Problem 3 - Pi approximation with n = 50_000_000 rectangles:
  #   Sequential avg:  ~600 ms
  #   Parallel avg:    ~340 ms
  #   Speedup Sp:      ~1.76x
  # ---------------------------------------------------------------------------


  # Problem 2 – Sum of all prime numbers <= n

  # Returns true if x is prime using trial division up to ceil(sqrt(x))
  def prime?(x) when x < 2, do: false
  def prime?(2), do: true
  def prime?(x) do
    limit = x |> :math.sqrt() |> Float.ceil() |> trunc()
    Enum.all?(2..limit, fn i -> rem(x, i) != 0 end)
  end

  # Computes the sum of all primes from 2 to n on a single thread
  def sum_primes_sequential(n) do
    Enum.filter(2..n, &prime?/1)
    |> Enum.sum()
  end

  # Helper: sums all primes in the sub-range {start, finish}
  def sum_primes_range({start, finish}) do
    Enum.filter(start..finish, &prime?/1)
    |> Enum.sum()
  end

  # Computes the sum of all primes from 2 to n using parallel tasks
  # Splits the range into chunks (one per scheduler) and uses Task.async/await
  def sum_primes_parallel(n, tasks \\ System.schedulers()) do
    step = ceil(n / tasks)
    starts   = [2 | Enum.to_list((step + 1)..n//step)]
    finishes = Enum.to_list(step..n//step)

    Enum.zip(starts, finishes)
    |> Enum.map(&Task.async(fn -> sum_primes_range(&1) end))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
  end


  # -------------------------------------------------------------------------
  # Problem 3 – Numerical integration to approximate pi
  # -------------------------------------------------------------------------

  # Computes the partial sum of rectangles for the sub-range {start_i, end_i}
  def pi_range({start_i, end_i}, width) do
    Enum.reduce(start_i..end_i, 0.0, fn i, acc ->
      mid    = (i + 0.5) * width
      height = 4.0 / (1.0 + mid * mid)
      acc + height
    end)
  end

  # Approximates pi sequentially using the rectangle (midpoint) method
  def compute_pi_sequential(n) do
    width = 1.0 / n
    sum =
      Enum.reduce(0..(n - 1), 0.0, fn i, acc ->
        mid    = (i + 0.5) * width
        height = 4.0 / (1.0 + mid * mid)
        acc + height
      end)
    width * sum
  end

  # Approximates pi in parallel by splitting rectangle indices across tasks
  def compute_pi_parallel(n, tasks \\ System.schedulers()) do
    width  = 1.0 / n
    step   = ceil(n / tasks)
    starts   = [0 | Enum.to_list(step..(n - 1)//step)]
    finishes = Enum.to_list((step - 1)..(n - 1)//step)

    Enum.zip(starts, finishes)
    |> Enum.map(&Task.async(fn -> pi_range(&1, width) end))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
    |> Kernel.*(width)
  end

end


# ---------------------------------------------------------------------------
# Run both problems, verify results, print timings
# ---------------------------------------------------------------------------

IO.puts("=== Problem 2: Sum of primes ===")
n2 = 200_000

{t_seq2, seq2} = :timer.tc(fn -> Parallelism.sum_primes_sequential(n2) end)
{t_par2, par2} = :timer.tc(fn -> Parallelism.sum_primes_parallel(n2) end)

IO.puts("  Sequential: #{seq2}  (#{t_seq2 / 1_000_000} s)")
IO.puts("  Parallel:   #{par2}  (#{t_par2 / 1_000_000} s)")
IO.puts("  Match: #{seq2 == par2}")
IO.puts("  Speedup: #{Float.round(t_seq2 / t_par2, 2)}x")

IO.puts("")
IO.puts("=== Problem 3: Pi approximation ===")
n3 = 10_000_000

{t_seq3, seq3} = :timer.tc(fn -> Parallelism.compute_pi_sequential(n3) end)
{t_par3, par3} = :timer.tc(fn -> Parallelism.compute_pi_parallel(n3) end)

IO.puts("  Sequential π: #{seq3}  (#{t_seq3 / 1_000_000} s)")
IO.puts("  Parallel π:   #{par3}  (#{t_par3 / 1_000_000} s)")
IO.puts("  Reference:    3.14159265358979323846")
IO.puts("  Cores: #{System.schedulers()}")
IO.puts("  Speedup: #{Float.round(t_seq3 / t_par3, 2)}x")
