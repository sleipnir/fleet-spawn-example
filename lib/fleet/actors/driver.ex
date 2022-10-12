defmodule Fleet.Actors.Driver do
  use SpawnSdk.Actor,
    abstract: true,
    state_type: Fleet.Domain.Driver

  alias Fleet.Domain.{
    Driver,
    OfferRequest,
    OfferResponse,
    Point
  }

  require Logger

  @brain_actor "fleet-controller"

  @impl true
  def handle_command(
        {:update_position, %Point{} = position},
        %Context{state: %Driver{id: name} = driver} = ctx
      ) do
    Logger.info(
      "Driver [#{name}] Received Update Position Event. Position: [#{inspect(position)}]. Context: #{inspect(ctx)}"
    )

    driver_state = %Driver{driver | position: position}

    invoke(@brain_actor,
      system: "spawn-system",
      command: "driver_position",
      payload: driver_state,
      async: true
    )

    Value.of()
    |> Value.value(driver_state)
    |> Value.state(driver_state)
    |> Value.reply!()
  end

  def handle_command(
        {:receive_offer, %OfferRequest{} = offer},
        %Context{state: %Driver{id: name} = _state} = ctx
      ) do
    Logger.info(
      "Driver [#{name}] Received Offer Request Event. Offer: [#{inspect(offer)}]. Context: #{inspect(ctx)}"
    )
  end
end
