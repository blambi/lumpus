defmodule Lumpus.World do
  def new(size) when size > 3 do
    create_grid(size)
  end

  def create_grid(size) do
    for _ <- 1..size, do: create_row(size)
  end

  def create_row(size) do
    create_row(nil, size)
  end

  def create_row(last, left) do
    room = Lumpus.World.Room.new()
    if !is_nil(last) do
      IO.puts("Linking rooms")
      Lumpus.World.Room.tunnel_rooms(room, last, :west)
    end

    if left > 0 do
      rooms = create_row(room, left - 1)
    else
      rooms = []
    end

    [room] ++ rooms
  end

  def get_room(world, row, column) do
    Enum.at(world, row)
    |> Enum.at(column)
  end
end
