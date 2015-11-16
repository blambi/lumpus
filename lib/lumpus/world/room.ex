defmodule Lumpus.World.Room do
  # A room will not know more then its content and neighbours
  def start_link() do
    Agent.start_link(fn -> Map.new end)
  end

  def new() do
    {:ok, room} = start_link()
    Agent.update(room, &Map.put(&1, 'tunnels', [nil, nil, nil, nil]))
    Agent.update(room, &Map.put(&1, 'contents', []))
    room
  end

  def tunnel_rooms(room_a, room_b, direction_a) do
    add_tunnel(room_a, room_b, direction_a)
    case direction_a do
      :north ->
        add_tunnel(room_b, room_a, :south)
      :south ->
        add_tunnel(room_b, room_a, :north)
      :east ->
        add_tunnel(room_b, room_a, :west)
      :west ->
        add_tunnel(room_b, room_a, :east)
    end
  end

  defp add_tunnel(room, target_room, direction) do
    Agent.update(room, fn(state) ->
      tunnels = Map.get(state, 'tunnels')
      index = direction_to_index(direction)
      tunnels = List.replace_at(tunnels, index, target_room)
      Map.put(state, 'tunnels', tunnels)
    end)
  end

  defp direction_to_index(direction) do
    case direction do
      :north -> 0
      :east  -> 1
      :south -> 2
      :west  -> 3
    end
  end

  def get_tunnels(room) do
    Agent.get(room, &Map.get(&1, 'tunnels'))
  end

  def add_thing(room, thing) do
    Agent.update(room, fn(state) ->
      contents = Map.get(state, 'contents')
      contents = contents ++ [thing]
      Map.put(state, 'contents', contents)
    end)
  end

  def get_contents(room) do
    Agent.get(room, &Map.get(&1, 'contents'))
  end

  @doc """
  Checks if any adjoining room to specified `room` contains `thing`
  """
  def is_near(room, thing) do
    rooms = Lumpus.World.Room.get_tunnels(room)

    Enum.any?(rooms, fn(r) ->
      get_contents(r)
      |> Enum.any?(fn(object) ->
        thing == object
      end)
    end)
  end
end
