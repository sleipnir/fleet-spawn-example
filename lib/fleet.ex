defmodule Fleet do
  @moduledoc """
  Documentation for `Fleet`.
  """

  alias SpawnSdk

  alias Fleet.Domain.{
    Driver,
    Point,
    State
  }

  @doc """
  Set the Fleet Controller Brain for specific location.

  ## Examples

      iex>  state = %Fleet.Domain.State{
              id: "fleet-controller-atibaia",
              area: %Fleet.Domain.Geometry{
                coordinates: [%Fleet.Domain.Point{latitude: -23.1171, longitude: -46.5502}]
              },
              deliveries: []
            }
      iex> Fleet.set_fleet_controller("fleet-controller-atibaia", state)
      %Fleet.Domain.State{
        id: "fleet-controller-atibaia",
        area: %Fleet.Domain.Geometry{
          coordinates: [
            %Fleet.Domain.Point{
              latitude: -23.1171,
              longitude: -46.5502,
              __unknown_fields__: []
            }
          ],
          __unknown_fields__: []
        },
        drivers: [],
        deliveries: [],
        __unknown_fields__: []
      }

  """
  def set_fleet_controller(area) do
    state = %State{
      id: "fleet-controller",
      area: area
    }

    SpawnSdk.invoke(
      "fleet-controller",
      system: "spawn-system",
      command: "init",
      payload: state
    )
  end

  def init_driver(driver) do
    SpawnSdk.invoke(
      driver.id,
      ref: Fleet.Actors.Driver,
      system: "spawn-system",
      command: "init",
      payload: driver
    )
  end

  def update_driver_position(driver_name, position) do
    SpawnSdk.invoke(
      driver_name,
      ref: Fleet.Actors.Driver,
      system: "spawn-system",
      command: "update_position",
      payload: position
    )
  end
end
