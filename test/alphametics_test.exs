defmodule AlphameticsTest do
  use ExUnit.Case
  doctest Alphametics

  test "puzzle with three letters" do
    input = "I + BB == ILL"
    expected = %{"I" => 1, "B" => 9, "L" => 0}
    assert Alphametics.solve(input) == expected
  end

  test "solution must have a unique value for each letter" do
    input = "A == B"
    expected = nil
    assert Alphametics.solve(input) == expected
  end

  test "leading zero solution is invalid" do
    input = "ACA + DD == BD"
    expected = nil
    assert Alphametics.solve(input) == expected
  end

  test "puzzle with four letters" do
    input = "AS + A == MOM"
    expected = %{"A" => 9, "S" => 2, "M" => 1, "O" => 0}
    assert Alphametics.solve(input) == expected
  end

  test "puzzle with six letters" do
    input = "NO + NO + TOO == LATE"
    expected = %{"N" => 7, "O" => 4, "T" => 9, "L" => 1, "A" => 0, "E" => 2}
    assert Alphametics.solve(input) == expected
  end

  test "puzzle with seven letters" do
    input = "HE + SEES + THE == LIGHT"
    expected =
      %{"H" => 5, "E" => 4, "S" => 9, "T" => 7, "L" => 1, "I" => 0, "G" => 2}
    assert Alphametics.solve(input) == expected
  end

  # test "puzzle with eight letters" do
  #   input = "SEND + MORE == MONEY"
  #   expected =
  #     %{"S" => 9, "E" => 5, "N" => 6, "D" => 7,
  #       "M" => 1, "O" => 0, "R" => 8, "Y" => 2}
  #   assert Alphametics.solve(input) == expected
  # end

  # test "puzzle with ten letters" do
  #   input = "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"
  #   expected =
  #     %{"A" => 5, "N" => 0, "D" => 3, "S" => 6, "T" => 9,
  #       "R" => 1, "O" => 2, "G" => 8, "F" => 7, "E" => 4}
  #   assert Alphametics.solve(input) == expected
  # end
end
