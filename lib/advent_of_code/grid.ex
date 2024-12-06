defmodule AdventOfCode.Grid do
  @moduledoc """
  Functions for working with grids.

  Grids are represented as two-dimensional lists, using a zero-indexed position system
  where the "origin" is located in the top-left corner.
  """

  alias AdventOfCode.Position

  @type t :: %__MODULE__{
          rows: list(list()),
          height: non_neg_integer(),
          width: non_neg_integer()
        }

  defstruct rows: [[]], height: 0, width: 0

  @doc """
  Creates a new grid from a list of lists.

  ## Examples
      iex> AdventOfCode.Grid.new([[1, 2], [3, 4]])
      %AdventOfCode.Grid{rows: [[1, 2], [3, 4]], height: 2, width: 2}
  """
  @spec new(list(list())) :: t()
  def new(rows \\ [[]]) do
    height = Enum.count(rows)
    width = rows |> List.first([]) |> Enum.count()

    %__MODULE__{rows: rows, height: height, width: width}
  end

  @doc """
  Retrieves the value at the given `position`, returning `default` if out of bounds.

  ## Examples
      iex> grid = AdventOfCode.Grid.new([[1, 2], [3, 4]])
      iex> AdventOfCode.Grid.at(grid, AdventOfCode.Position.new(1, 1))
      4
      iex> AdventOfCode.Grid.at(grid, AdventOfCode.Position.new(3, 3), :not_found)
      :not_found
  """
  @spec at(t(), Position.t(), term()) :: term()
  def at(grid, position, default \\ nil)

  def at(%__MODULE__{rows: rows} = grid, %Position{x: x, y: y} = position, default) do
    if in_bounds?(grid, position) do
      rows
      |> Enum.at(y, [])
      |> Enum.at(x, default)
    else
      default
    end
  end

  @doc """
  Safely fetches the value at the given `position`.

  Returns value {:ok, value} if in bounds, :error otherwise.

  ## Examples
      iex> grid = AdventOfCode.Grid.new([[1, 2], [3, 4]])
      iex> AdventOfCode.Grid.fetch(grid, AdventOfCode.Position.new(1, 1))
      {:ok, 4}
      iex> AdventOfCode.Grid.fetch(grid, AdventOfCode.Position.new(3, 3))
      :error
  """
  @spec fetch(t(), Position.t()) :: {:ok, term()} | :error
  def fetch(grid, position)

  def fetch(%__MODULE__{} = grid, %Position{} = position) do
    if in_bounds?(grid, position) do
      {:ok, at(grid, position)}
    else
      :error
    end
  end

  defp in_bounds?(%__MODULE__{width: width, height: height}, %Position{x: x, y: y}) do
    x >= 0 and y >= 0 and x < width and y < height
  end
end
