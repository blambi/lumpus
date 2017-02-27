defmodule Lumpus.Game do
  # Used by all "players" etc to poke around in the world, and all
  # glue logic. And it keeps track of all the states (indirectly)
  require Logger
  use GenServer

  alias Lumpus.World
  alias Lumpus.World.Room

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [name: __MODULE__])
  end

  def init(size) when is_integer(size) do
    :rand.seed(:os.timestamp)
    # I have no idea what old me wanted to do with this.. {:ok, manager} = GenEvent.start_link
    {:ok, %{
        world: World.new(size),
        players: %{},
        }
    }
  end

  @doc """
  Register/Resume player

  Returns
  """
  def player_join(nick) do
    GenServer.call(__MODULE__, {:join, nick})
  end

  def player_move(nick, target_room) when is_integer(target_room) do
    GenServer.call(__MODULE__, {:move, nick, target_room})
  end

  def player_shoot(nick, target_room) when is_integer(target_room) do
    GenServer.call(__MODULE__, {:shoot, nick, target_room})
  end


  ## Callbacks
  def handle_call({:join, nick}, _from, %{world: world, players: players} = state) do
    # FIXME: clean up this mess.


    # Check if registered, if so return that user state
    {player_id, players} =
      with {:ok, player_id} <- Map.fetch(players, nick) do
        {player_id, players}
      else
        :error ->
          # Create player and place it where ever
          room = Lumpus.World.get_random_room(world)
          player_id = Lumpus.Player.new(nick, room)
          Map.put(players, nick, player_id)

          {player_id, players}
      end

    reply = Lumpus.Player.get_state(player_id)
    new_state = Map.put(state, :players, players)
    {:reply, reply, new_state}
  end


  def handle_call({:move, nick, target_room}, _from, state) do
    {:reply, :not_implemented, state}
  end


  def handle_call({:shoot, nick, target_room}, _from, state) do
    {:reply, :not_implemented, state}
  end
end
