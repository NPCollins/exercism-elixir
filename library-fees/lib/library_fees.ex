defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime
  def datetime_from_string(string) do
    {:ok, datetime, _} = DateTime.from_iso8601(string)
    DateTime.to_naive(datetime)
  end

  @spec before_noon?(NaiveDateTime) :: boolean()
  def before_noon?(naive_datetime) do
    {:ok, datetime} = DateTime.from_naive(naive_datetime, "Etc/UTC") 
    time = DateTime.to_time(datetime)
    Time.before?(time, ~T[12:00:00])
  end

  @spec return_date(NaiveDateTime) :: Date
  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    {:ok, datetime} = DateTime.from_naive(checkout_datetime, "Etc/UTC")
    DateTime.add(datetime, days, :day) |> DateTime.to_date
  end

  @spec days_late(Date, NaiveDateTime) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    {:ok, return_datetime} = DateTime.from_naive(actual_return_datetime, "Etc/UTC")
    return_date = DateTime.to_date(return_datetime)
    days = Date.diff(return_date, planned_return_date)
    if days >= 0, do: days, else: 0
  end

  @spec monday?(NaiveDateTime) :: boolean()
  def monday?(datetime) do
    {:ok, datetime} = DateTime.from_naive(datetime, "Etc/UTC")
    day_of_week = DateTime.to_date(datetime) |> Date.day_of_week()
    day_of_week == 1
  end

  @spec calculate_late_fee(String.t(), String.t(), non_neg_integer()) :: non_neg_integer()
  def calculate_late_fee(checkout, return, rate) do
    naive_checkout = datetime_from_string(checkout)
    planned_return_date = return_date(naive_checkout)
    naive_return = datetime_from_string(return)

    fee = days_late(planned_return_date, naive_return) * rate
    if monday?(naive_return) do
      (fee / 2) |> trunc()
    else
      fee
    end
  end
end
