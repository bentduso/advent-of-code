defmodule AdventOfCode.Position do
  @moduledoc """
  Provides navigation functions for grid positions, allowing movement in different directions.
  """

  @type t :: %__MODULE__{
          x: integer(),
          y: integer()
        }

  defstruct x: 0, y: 0

  @doc """
  Creates a new position with coordinates `x` and `y`.

  ## Examples
      iex> AdventOfCode.Position.new(1, 2)
      %AdventOfCode.Position{x: 1, y: 2}
  """
  @spec new(integer(), integer()) :: t()
  def new(x, y), do: %__MODULE__{x: x, y: y}

  @doc """
  Moves a position north.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_north(pos, 1)
      %AdventOfCode.Position{x: 5, y: 4}
      iex> AdventOfCode.Position.move_north(pos, 2)
      %AdventOfCode.Position{x: 5, y: 3}
  """
  @spec move_north(t(), integer()) :: t()
  def move_north(position, steps \\ 1)
  def move_north(%__MODULE__{x: x, y: y}, steps), do: new(x, y - steps)

  @doc """
  Moves a position east.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_east(pos, 1)
      %AdventOfCode.Position{x: 6, y: 5}
      iex> AdventOfCode.Position.move_east(pos, 2)
      %AdventOfCode.Position{x: 7, y: 5}
  """
  @spec move_east(t(), integer()) :: t()
  def move_east(position, steps \\ 1)
  def move_east(%__MODULE__{x: x, y: y}, steps), do: new(x + steps, y)

  @doc """
  Moves a position south.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_south(pos, 1)
      %AdventOfCode.Position{x: 5, y: 6}
      iex> AdventOfCode.Position.move_south(pos, 2)
      %AdventOfCode.Position{x: 5, y: 7}
  """
  @spec move_south(t(), integer()) :: t()
  def move_south(position, steps \\ 1)
  def move_south(%__MODULE__{x: x, y: y}, steps), do: new(x, y + steps)

  @doc """
  Moves a position west.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_west(pos, 1)
      %AdventOfCode.Position{x: 4, y: 5}
      iex> AdventOfCode.Position.move_west(pos, 2)
      %AdventOfCode.Position{x: 3, y: 5}
  """
  @spec move_west(t(), integer()) :: t()
  def move_west(position, steps \\ 1)
  def move_west(%__MODULE__{x: x, y: y}, steps), do: new(x - steps, y)

  @doc """
  Moves a position diagonally northeast.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_north_east(pos, 1)
      %AdventOfCode.Position{x: 6, y: 4}
      iex> AdventOfCode.Position.move_north_east(pos, 2)
      %AdventOfCode.Position{x: 7, y: 3}
  """
  @spec move_north_east(t(), integer()) :: t()
  def move_north_east(position, steps \\ 1)

  def move_north_east(%__MODULE__{} = position, steps) do
    position
    |> move_north(steps)
    |> move_east(steps)
  end

  @doc """
  Moves a position diagonally northwest.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_north_west(pos, 1)
      %AdventOfCode.Position{x: 4, y: 4}
      iex> AdventOfCode.Position.move_north_west(pos, 2)
      %AdventOfCode.Position{x: 3, y: 3}
  """
  @spec move_north_west(t(), integer()) :: t()
  def move_north_west(position, steps \\ 1)

  def move_north_west(%__MODULE__{} = position, steps) do
    position
    |> move_north(steps)
    |> move_west(steps)
  end

  @doc """
  Moves a position diagonally southeast.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_south_east(pos, 1)
      %AdventOfCode.Position{x: 6, y: 6}
      iex> AdventOfCode.Position.move_south_east(pos, 2)
      %AdventOfCode.Position{x: 7, y: 7}
  """
  @spec move_south_east(t(), integer()) :: t()
  def move_south_east(position, steps \\ 1)

  def move_south_east(%__MODULE__{} = position, steps) do
    position
    |> move_south(steps)
    |> move_east(steps)
  end

  @doc """
  Moves a position diagonally southwest.

  ## Examples
      iex> pos = AdventOfCode.Position.new(5, 5)
      iex> AdventOfCode.Position.move_south_west(pos, 1)
      %AdventOfCode.Position{x: 4, y: 6}
      iex> AdventOfCode.Position.move_south_west(pos, 2)
      %AdventOfCode.Position{x: 3, y: 7}
  """
  @spec move_south_west(t(), integer()) :: t()
  def move_south_west(position, steps \\ 1)

  def move_south_west(%__MODULE__{} = position, steps) do
    position
    |> move_south(steps)
    |> move_west(steps)
  end

  @doc """
  Returns all available movement directions.
  """
  @spec directions() :: [atom()]
  def directions() do
    [
      :north,
      :east,
      :south,
      :west,
      :north_east,
      :north_west,
      :south_east,
      :south_west
    ]
  end
end
