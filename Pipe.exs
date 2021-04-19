defmodule Pipe do

  def piping(string) do
    string
    |> String.trim()
    |> String.capitalize()
    |> String.replace("hear", "here")
    |> String.replace("?", "!")
  end

end
