defmodule Fleet.Actors.Brain do
  use SpawnSdk.Actor,
    name: "fleet-controller",
    channel: "fleet-controllers",
    state_type: Fleet.Domain.State,
    deactivate_timeout: 31_536_000_000

  alias Fleet.Domain.{
    Delivery,
    Driver,
    Geometry,
    OfferRequest,
    OfferResponse,
    Point,
    State
  }

  require Logger

  defact init(%State{} = initial_state, ctx) do
    Logger.info("Fleet Brain Controller Received Init Event. Context: #{inspect(ctx)}")

    %Value{}
    |> Value.of(initial_state, initial_state)
    |> Value.reply!()
  end

  @set_timer 60_000
  defact dequeue_delivery(_request, %Context{state: state} = ctx) do
    Logger.info(
      "Fleet Brain Controller Received Dequeue Delivery Event. Context: #{inspect(ctx)}"
    )

    Value.of()
    |> Value.state(state)
    |> Value.noreply!()
  end

  defact enqueue_delivery(%Delivery{} = delivery, %Context{state: state} = ctx)
         when is_nil(state) do
    Logger.info(
      "Fleet Brain Controller Received Enqueue Delivery Event. Context: #{inspect(ctx)}"
    )

    new_state = %State{deliveries: [delivery]}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end

  defact enqueue_delivery(
           %Delivery{} = delivery,
           %Context{state: %State{deliveries: deliveries} = state} = ctx
         ) do
    Logger.info(
      "Fleet Brain Controller Received Enqueue Delivery Event. Context: #{inspect(ctx)}"
    )

    updated_deliveries = deliveries ++ [delivery]
    new_state = %State{state | deliveries: updated_deliveries}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end

  defact driver_position(
           %Driver{} = driver,
           %Context{state: %State{drivers: drivers} = state} = ctx
         ) do
    Logger.info(
      "Fleet Brain Controller Received Driver Position Event. Driver: [#{inspect(driver)}] Context: #{inspect(ctx)}"
    )

    updated_drivers = drivers ++ [driver]
    new_state = %State{state | drivers: updated_drivers}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end
end
