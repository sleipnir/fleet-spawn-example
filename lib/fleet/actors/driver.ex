defmodule Fleet.Actors.Driver do
  use SpawnSdk.Actor,
    abstract: true,
    channel: "drivers",
    state_type: Fleet.Domain.Driver

  alias Fleet.Domain.{
    Driver,
    OfferRequest,
    OfferResponse,
    Point
  }

  require Logger

  @brain_actor_channel "fleet-controllers"

  defact update_position(
           %Point{} = position,
           %Context{state: %Driver{id: name} = driver} = ctx
         ) do
    Logger.info(
      "Driver [#{name}] Received Update Position Event. Position: [#{inspect(position)}]. Context: #{inspect(ctx)}"
    )

    driver_state = %Driver{driver | position: position}

    %Value{}
    |> Value.of(driver_state, driver_state)
    |> Value.broadcast(
      Broadcast.to(
        @brain_actor_channel,
        "driver_position",
        driver_state
      )
    )
    |> Value.reply!()
  end

  defact init(%Driver{} = initial_state, ctx) do
    Logger.info("Driver Received Init Event. Context: #{inspect(ctx)}")

    %Value{}
    |> Value.of(initial_state, initial_state)
    |> Value.reply!()
  end

  defact receive_offer(
           %OfferRequest{} = offer,
           %Context{state: %Driver{id: name} = _state} = ctx
         ) do
    Logger.info(
      "Driver [#{name}] Received Offer Request Event. Offer: [#{inspect(offer)}]. Context: #{inspect(ctx)}"
    )
  end
end
