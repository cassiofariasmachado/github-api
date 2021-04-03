ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Github.Repo, :manual)
Mox.defmock(Github.ClientMock, for: Github.Client.Behaviour)
