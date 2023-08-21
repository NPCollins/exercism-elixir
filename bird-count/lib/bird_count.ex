defmodule BirdCount do
  def today(list)
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count(list)
  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?(list)
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  def total(list, count \\ 0)
  def total([], count), do: count
  def total([head | tail], count), do: total(tail, count + head)

  def busy_days(list, count \\ 0)
  def busy_days([], count), do: count
  def busy_days([head | tail], count) when head >= 5, do: busy_days(tail, count + 1)
  def busy_days([head | tail], count) when head < 5, do: busy_days(tail, count)
end
