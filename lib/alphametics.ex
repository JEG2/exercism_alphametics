defmodule Alphametics do
  defstruct letters: nil,
            terms: [ ],
            operands: [ ],
            sum: nil,
            possible_values: %{ }

  def solve(equation) do
    equation
    |> find_terms
    |> generate_possible_values
    |> find_solution
  end

  defp find_terms(equation) do
    data =
      Regex.scan(~r{\w+}, equation)
      |> Enum.reduce(
        %__MODULE__{ },
        fn term, data ->
          %__MODULE__{
            data |
            terms: data.terms ++ term,
            operands: data.operands ++ List.wrap(data.sum),
            sum: hd(term)
          }
        end
      )
    %__MODULE__{
      data |
      letters: data.terms |> Enum.join |> String.graphemes |> Enum.uniq
    }
  end

  defp generate_possible_values(data) do
    data
    |> generate_all_possible_values(data.letters)
  end

  defp generate_all_possible_values(data, [letter | letters]) do
    starts_a_term =
      Enum.any?(
        data.terms,
        fn term -> String.starts_with?(term, letter) end
      )
    possible_start =
      if starts_a_term, do: 1, else: 0
    %__MODULE__{
      data |
      possible_values: Map.put(
        data.possible_values,
        letter,
        Enum.to_list(possible_start..9)
      )
    }
    |> generate_all_possible_values(letters)
  end
  defp generate_all_possible_values(data, [ ]), do: data

  defp find_solution(data) do
    search_solution_space(data, data.letters, %{ })
  end

  defp search_solution_space(data, [letter | letters], solution) do
    Map.fetch!(data.possible_values, letter)
    |> Enum.find_value(fn number ->
      if number in Map.values(solution) do
        nil
      else
        search_solution_space(data, letters, Map.put(solution, letter, number))
      end
    end)
  end
  defp search_solution_space(data, [ ], solution) do
    if solved?(data, solution) do
      solution
    else
      nil
    end
  end

  defp solved?(data, solution) do
    total =
      Enum.reduce(
        data.operands,
        0,
        fn term, sum -> sum + substitute(term, solution) end
      )
    total == substitute(data.sum, solution)
  end

  defp substitute(term, solution) do
    term
    |> String.graphemes
    |> Enum.map(fn letter -> Map.fetch!(solution, letter) end)
    |> Enum.join
    |> String.to_integer
  end
end
