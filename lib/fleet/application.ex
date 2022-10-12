defmodule Fleet.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        SpawnSdk.System.Supervisor,
        system: "spawn-system",
        actors: [
          Fleet.Actors.Brain,
          Fleet.Actors.Driver
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: Fleet.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
