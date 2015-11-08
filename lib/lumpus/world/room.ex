defmodule Lumpus.World.Room do
  # A room will not know more then its content and neighbours
  def start_link() do
    Agent.start_link(fn -> HashDict.new end)
  end

  def new() do
    {:ok, room} = start_link()
    Agent.update(room, &HashDict.put(&1, 'tunnels', [nil, nil, nil, nil]))
    Agent.update(room, &HashDict.put(&1, 'contents', []))
    room
  end

  def tunnel_rooms(room_a, room_b, direction_a) do
    case direction_a do
      :north ->
        tunnel_rooms(room_a, room_b, direction_a, :south)
      :south ->
        tunnel_rooms(room_a, room_b, direction_a, :north)
      :east ->
        tunnel_rooms(room_a, room_b, direction_a, :west)
      :west ->
        tunnel_rooms(room_a, room_b, direction_a, :east)
    end
  end

  defp tunnel_rooms(room_a, room_b, direction_a, direction_b) do
    # FIXME: as with add thing this is just an ugly hack
    tunnels_a = Agent.get(room_a, &HashDict.get(&1, 'tunnels'))
    index_a = direction_to_index(direction_a)
    tunnels_a = List.replace_at(tunnels_a, index_a, room_b)
    Agent.update(room_a, &HashDict.put(&1, 'tunnels', tunnels_a))

    tunnels_b = Agent.get(room_b, &HashDict.get(&1, 'tunnels'))
    index_b = direction_to_index(direction_b)
    tunnels_b = List.replace_at(tunnels_b, index_b, room_a)
    Agent.update(room_b, &HashDict.put(&1, 'tunnels', tunnels_b))
  end

  defp direction_to_index(direction) do
    case direction do
      :north -> 0
      :south -> 1
      :east  -> 2
      :west  -> 3
    end
  end

  def get_tunnels(room) do
    Agent.get(room, &HashDict.get(&1, 'tunnels'))
  end

  def add_thing(room, thing) do
    # FIXME: This is a hack until we get it rolling
    #        We should be able to have this in one get_update?
    h = Agent.get(room, &HashDict.get(&1, 'contents'))
    h = h ++ [thing]
    Agent.update(room, &HashDict.put(&1, 'contents', h))

    # This was apparently wrong
    #Agent.get_and_update(room, fn(state) ->
    #  h = HashDict.get(state, 'contents')
    #  h = h ++ [thing]
    #  HashDict.update(state, 'contents', h)
    #  {h, h}
    #end)
  end

  def get_contents(room) do
    Agent.get(room, &HashDict.get(&1, 'contents'))
  end
end
