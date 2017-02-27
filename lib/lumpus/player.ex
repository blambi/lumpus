defmodule Lumpus.Player do
  # Ingame knowledge about a player

  def start_link() do
    Agent.start_link(fn -> Map.new end) # We should probably use structs for this later but for now map is ok
  end

  def new(nick, room) do
    {:ok, player} = start_link()
    Agent.update(player, &Map.put(&1, "nick", nick))
    Agent.update(player, &Map.put(&1, "arrows", 3))
    Agent.update(player, &Map.put(&1, "room", room))
    player
  end

  def get_state(player) do
    # Just return the full state
    Agent.get(player, fn(x) -> x end)
  end

  def move(player, new_room) do
    Agent.update(player, &Map.put(&1, "room", new_room))
  end
end
