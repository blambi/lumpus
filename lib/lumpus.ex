defmodule Lumpus do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Lumpus.Game, [5])
    ]

    Supervisor.start_link(children, strategy: :rest_for_one)
  end
end
