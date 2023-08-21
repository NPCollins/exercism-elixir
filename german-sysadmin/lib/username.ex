defmodule Username do
  @spec sanitize(charlist(), charlist()) :: charlist()
  def sanitize(email, out \\ [])
  def sanitize([], out), do: out
  def sanitize([head | tail], out) do
    case head do
      head when head >= ?a and head <= ?z -> sanitize(tail, out ++ [head])
      head when head == ?_ -> sanitize(tail, out ++ [head])
      head when head == ?ä -> sanitize(tail, out ++ [?a, ?e])
      head when head == ?ö -> sanitize(tail, out ++ [?o, ?e])
      head when head == ?ü -> sanitize(tail, out ++ [?u, ?e])
      head when head == ?ß -> sanitize(tail, out ++ [?s, ?s])
      _ -> sanitize(tail, out)
    end
  end
end
