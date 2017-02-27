defmodule Lumpus.World do
  def new(size) when size > 3 do
    create_grid(size)
    |> weave_rows(size)
  end

  def create_grid(size) do
    for _ <- 1..size, do: create_row(size)
  end

  def create_row(size) do
    create_row(nil, size)
  end

  defp create_row(last, left) do
    room = Lumpus.World.Room.new()
    if !is_nil(last) do
      Lumpus.World.Room.tunnel_rooms(room, last, :west)
    end

    if left > 1 do # 1 is last..
      rooms = create_row(room, left - 1)
    else
      rooms = []
    end

    [room] ++ rooms
  end

  def weave_rows(rows, size) do
    weave_rows(rows, size, 0)
    # nothing needed, it happens in the room processes, so just return
    rows
  end

  defp weave_rows(rows, size, position) do
    if position < size - 1 do # nock down the last to avoid bottom being empty
      top_row = Enum.at(rows, position)
      bottom_row = Enum.at(rows, position + 1)

      weave_columns_between_rows(top_row, bottom_row, size)
      weave_rows(rows, size, position + 1)
    else
      # Wrap here
    end
  end

  defp weave_columns_between_rows(top, bottom, size) do
    weave_columns_between_rows(top, bottom, size, 0)
  end

  defp weave_columns_between_rows(top, bottom, size, position) do
    if position < size do
      top_room = Enum.at(top, position)
      bottom_room = Enum.at(bottom, position)

      Lumpus.World.Room.tunnel_rooms(bottom_room, top_room, :north)
      weave_columns_between_rows(top, bottom, size, position + 1)
    end
  end

  def get_room(world, row, column) do
    Enum.at(world, row)
    |> Enum.at(column)
  end

  def get_random_room(world) do
    # TODO: Just totaly random to get it working for now..
    #       later ensure that room is empty.
    size =
      Enum.at(world, 0)
      |> length()

    get_room(
      world,
      :rand.uniform(size),
      :rand.uniform(size)
    )
  end
end
