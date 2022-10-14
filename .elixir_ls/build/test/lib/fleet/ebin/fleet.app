{application,fleet,
             [{applications,[kernel,stdlib,elixir,logger,spawn_sdk,uniq]},
              {description,"fleet"},
              {modules,['Elixir.Fleet','Elixir.Fleet.Actors.Brain',
                        'Elixir.Fleet.Actors.Driver',
                        'Elixir.Fleet.Application',
                        'Elixir.Fleet.Domain.Container',
                        'Elixir.Fleet.Domain.Delivery',
                        'Elixir.Fleet.Domain.DeliveryStatus',
                        'Elixir.Fleet.Domain.Driver',
                        'Elixir.Fleet.Domain.Geometry',
                        'Elixir.Fleet.Domain.Item',
                        'Elixir.Fleet.Domain.OfferRequest',
                        'Elixir.Fleet.Domain.OfferResponse',
                        'Elixir.Fleet.Domain.OfferStatus',
                        'Elixir.Fleet.Domain.Point',
                        'Elixir.Fleet.Domain.State']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.Fleet.Application',[]}}]}.