defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  defstruct direction: :north, position: {0, 0}

  defguard is_position(x, y) when is_integer(x) and is_integer(y)
  defguard is_direction(direction) when direction in [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _position) when not is_direction(direction) do
    {:error, "invalid direction"}
  end

  def create(direction, position = {x, y}) when is_position(x, y) do
    %__MODULE__{
      direction: direction,
      position: position
    }
  end

  def create(_direction, _position) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    cond do
      instructions =~ ~r/[B-KM-QS-Z]/ ->
        {:error, "invalid instruction"}

      true ->
        instructions
        |> String.graphemes()
        |> Enum.reduce(robot, fn s, acc ->
          move(s, acc)
        end)
    end
  end

  defp move("L", %{direction: direction} = robot) do
    %__MODULE__{
      robot
      | direction:
          case direction do
            :north -> :west
            :west -> :south
            :south -> :east
            :east -> :north
          end
    }
  end

  defp move("R", %{direction: direction} = robot) do
    %__MODULE__{
      robot
      | direction:
          case direction do
            :north -> :east
            :east -> :south
            :south -> :west
            :west -> :north
          end
    }
  end

  defp move("A", %{position: {x, y}, direction: direction} = robot) do
    %__MODULE__{
      robot
      | position:
          case direction do
            :north -> {x, y + 1}
            :east -> {x + 1, y}
            :south -> {x, y - 1}
            :west -> {x - 1, y}
          end
    }
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: direction} = _robot), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: position} = _robot), do: position
end
