{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = StrawHat.Map.Tests.IsoGeneratorServer.start_link()
{:ok, _} = StrawHat.Map.Repo.start_link()

ExUnit.start()
