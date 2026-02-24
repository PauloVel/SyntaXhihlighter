# First Elixir program
# Find the date of the next day
#
# Gilberto Echeverria
# 2026-02-24

# Create a new module
defmodule Dates do

  def leap_explicit?(year) do
    if rem(year, 4) == 0 do
      true
    else
      false
    end
  end

  def leap_long?(year) do
    rem(year, 4) == 0
  end

  def leap?(year), do: rem(year, 4) == 0

  def month_days(month, year) do
    # Check for multiple different conditions
    cond do
      month == 2 -> if leap?(year), do: 29, else: 28
      month in [4, 6, 9, 11] -> 30
      true -> 31
    end
  end

  def next_day(day, month, year) do
    {day, month, year}
  end

end
