defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40

  def remaining_minutes_in_oven(elapsed_time), do: expected_minutes_in_oven() - elapsed_time

  def preparation_time_in_minutes(layers), do: layers * 2

  def total_time_in_minutes(layers, elapsed_time), do: elapsed_time + preparation_time_in_minutes(layers)

  def alarm(), do: "Ding!"
end
