defmodule RPG.CharacterSheet do
  @spec welcome() :: :ok
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  @spec ask_name() :: String.t()
  def ask_name() do
    name = IO.gets("What is your character's name?\n") |> String.trim
    name
  end

  @spec ask_class() :: String.t()
  def ask_class() do
    class = IO.gets("What is your character's class?\n") |> String.trim
    class
  end

  @spec ask_level() :: integer()
  def ask_level() do
    level = IO.gets("What is your character's level?\n") |> String.trim
    level |> String.to_integer
  end

  @type character :: %{name: String.t(), class: String.t(), level: String.t()}
  @spec run() :: character
  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    character = %{name: name, class: class, level: level}
    IO.inspect(character, label: "Your character")
  end
end
