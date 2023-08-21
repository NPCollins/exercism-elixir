defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name |> String.trim_leading |> String.first
  end

  def initial(name) do
    first_letter(name) |> String.upcase |> Kernel.<> "."
  end

  def initials(full_name) do
    [first_name, last_name] = full_name |> String.split(" ")
    "#{initial(first_name)} #{initial(last_name)}"
  end

  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    # Please implement the pair/2 function
  end
end
