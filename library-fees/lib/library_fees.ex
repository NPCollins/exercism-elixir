defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  @spec before_noon?(NaiveDateTime) :: boolean()
  def before_noon?(naive_datetime) do
    time = NaiveDateTime.to_time(naive_datetime)
    Time.before?(time, ~T[12:00:00])
  end

  @spec return_date(NaiveDateTime) :: Date
  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    NaiveDateTime.add(checkout_datetime, days, :day) |> NaiveDateTime.to_date
  end

  @spec days_late(Date, NaiveDateTime) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    return_date = NaiveDateTime.to_date(actual_return_datetime)
    days = Date.diff(return_date, planned_return_date)
    if days >= 0, do: days, else: 0
  end

  @spec monday?(NaiveDateTime) :: boolean()
  def monday?(datetime) do
    day_of_week = NaiveDateTime.to_date(datetime) |> Date.day_of_week()
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
