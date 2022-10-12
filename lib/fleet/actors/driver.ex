defmodule Fleet.Actors.Driver do
  use SpawnSdk.Actor,
    abstract: true,
    state_type: Fleet.Domain.Driver

  alias Fleet.Domain.{
    OfferRequest,
    OfferResponse
  }

  require Logger

  @impl true
  def handle_command({:receive_offer, %OfferRequest{} = _request}, %Context{state: _state} = _ctx) do
  end
end
