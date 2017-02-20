defmodule Lumpus.Game do
  # Used by all "players" etc to poke around in the world
  use GenServer

  alias Lumpus.World
  alias Lumpus.World.Room

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [name: __MODULE__])
  end

  def init(size) when is_integer(size) do
    :random.seed(:os.timestamp)
    # I have no idea what old me wanted to do with this.. {:ok, manager} = GenEvent.start_link
    {:ok, %{
        world: World.new(size),
        players: %{},
        }
    }
  end

  @doc """
  Register/Resume player
  """
  def player_join(nick) do
  end

  def player_move(nick, target_room) when is_integer(target_room) do
  end

  def player_shoot(nick, target_room) when is_integer(target_room) do
  end
end
