defmodule NameBadge do
  def print(id, name, department) do
    cond do
      !id && !department -> "#{name} - OWNER"
      !department -> "[#{id}] - #{name} - OWNER"
      !id -> "#{name} - #{department |> String.upcase()}"
      true -> "[#{id}] - #{name} - #{department |> String.upcase()}"
    end
  end
end
