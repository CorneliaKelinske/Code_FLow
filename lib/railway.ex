# ---
# Excerpted from "Thinking Elixir - CodeFlow", published by Mark Ericksen.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact me if you are in doubt. I make
# no guarantees that this code is fit for any purpose. Visit
# https://thinkingelixir.com/available-courses/code-flow/ for course
# information.
# ---
defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = user, _inc_point_value) do
    user
    |> user_active?()
    |> verify_age(16)
    |> check_blacklist()
    


  end

  defp user_active?(%User{active: true} = user), do: {:ok, user}
  defp user_active?(_user), do: {:error, "Not an active User"}


  #defp verify_age({:ok, %User{age: nil} = user}, _cutoff_age), do: {:error, "unable to verify age"}
  defp verify_age({:ok, %User{age: age} = user}, cutoff_age) when age >= cutoff_age do
    {:ok, user}
  end
  defp verify_age({:ok, _user}, _cutoff_age), do: {:error, "User age is below the cutoff"}
  defp verify_age(error, _cutoff_age), do: error

  defp check_blacklist({:ok, %User{name: name} = _user}) when name in ["Tom", "Tim", "Tammy"] do
    {:error, "User #{inspect(name)} is blacklisted"}
  end

  defp check_blacklist({:ok, user}), do: {:ok, user}
  defp check_blacklist(error), do: error

end
