{application,spawn_sdk,
             [{applications,[kernel,stdlib,elixir,logger,actors,spawn,
                             sidecar]},
              {description,"spawn_sdk"},
              {modules,['Elixir.SpawnSdk','Elixir.SpawnSdk.Actor',
                        'Elixir.SpawnSdk.Context','Elixir.SpawnSdk.Defact',
                        'Elixir.SpawnSdk.Flow',
                        'Elixir.SpawnSdk.Flow.Broadcast',
                        'Elixir.SpawnSdk.Flow.SideEffect',
                        'Elixir.SpawnSdk.Interface','Elixir.SpawnSdk.System',
                        'Elixir.SpawnSdk.System.SpawnSystem',
                        'Elixir.SpawnSdk.System.Supervisor',
                        'Elixir.SpawnSdk.Value']},
              {registered,[]},
              {vsn,"0.1.0"}]}.