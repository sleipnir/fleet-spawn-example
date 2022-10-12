defmodule Fleet.Actors.Brain do
  use SpawnSdk.Actor,
    abstract: true,
    state_type: Fleet.Domain.State,
    deactivate_timeout: 31_536_000_000,
    actions: [
      :enqueue_delivery,
      :receive_driver_position
    ],
    timers: [dequeue_delivery: 10_000]

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

  @impl true
  def handle_command({:init, %State{} = initial_state}, ctx) do
    Value.of(initial_state, initial_state)
    |> Value.reply!()
  end

  def handle_command({:dequeue_delivery, _request}, %Context{state: state} = ctx)
      when is_nil(state) do
    Logger.info(
      "Fleet Brain Controller Received Dequeue Delivery Event. Context: #{inspect(ctx)}"
    )

    new_state = %State{}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end

  def handle_command({:dequeue_delivery, _request}, %Context{state: state} = ctx) do
    Logger.info(
      "Fleet Brain Controller Received Dequeue Delivery Event. Context: #{inspect(ctx)}"
    )

    Value.of()
    |> Value.state(state)
    |> Value.noreply!()
  end

  @impl true
  def handle_command({:enqueue_delivery, %Delivery{} = delivery}, %Context{state: state} = ctx)
      when is_nil(state) do
    new_state = %State{deliveries: [delivery]}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end

  @impl true
  def handle_command(
        {:enqueue_delivery, %Delivery{} = delivery},
        %Context{state: %Fleet.Domain.State{deliveries: deliveries} = state} = ctx
      ) do
    updated_deliveries = deliveries ++ [delivery]
    new_state = %State{deliveries: updated_deliveries}

    Value.of()
    |> Value.state(new_state)
    |> Value.noreply!()
  end

  @impl true
  def handle_command(
        {:receive_driver_position, %Driver{position: position} = driver},
        %Context{state: state} = ctx
      ) do
  end
end
