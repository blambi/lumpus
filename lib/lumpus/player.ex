defmodule Lumpus.Player do
  # Ingame knowledge about a player

  def start_link() do
    Agent.start_link(fn -> Map.new end) # We should probably use structs for this later but for now map is ok
  end

  def new(nick) do
    {:ok, player} = start_link()
    Agent.update(player, &Map.put(&1, "nick", nick))
    player
  end
end
