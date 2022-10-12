defmodule FleetTest do
  use ExUnit.Case
  doctest Fleet

  test "greets the world" do
    state = %Fleet.Domain.State{
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

    assert Fleet.set_fleet_controller("fleet-controller-atibaia", state) == %Fleet.Domain.State{
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
  end
end
