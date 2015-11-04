defmodule Lumpus.World do
  def new(size) when size > 3 do
    create_grid(size)
  end

  def create_grid(size) do
    for _ <- 1..size, do: create_row(size)
  end

  # def create_row(size) do
  #   room = Lumpus.World.Room.new()
  #   create_row(size-1, room)

  #   room
  # end

  # def create_row(left, last) do
  #   room = Lumpus.World.Room.new()
  #   if !is_nil(last) do
  #     Lumpus.World.Room.tunnel_rooms(room, last, :west)
  #   end

  #   if left >= 0 do
  #     create_row(left-1, room)
  #   end

  #   room
  # end
  
  def create_row(size) do
    # FIXME: the last idea doesn't work at all here..
    room = nil # used for both keeping track of our room and the last room..
    for _ <- 1..size do
      room = create_column(room)
    end
  end

  def create_column(last) do
    room = Lumpus.World.Room.new()
    if !is_nil(last) do
      IO.puts("Linking rooms")
      Lumpus.World.Room.tunnel_rooms(room, last, :west)
    end
    room
  end

  def get_room(world, row, column) do
    Enum.at(world, row)
    |> Enum.at(column)
  end
end

