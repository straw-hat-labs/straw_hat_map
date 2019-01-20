{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = StrawHat.Map.TestSupport.IsoGeneratorServer.start_link()
{:ok, _} = StrawHat.Map.TestSupport.Repo.start_link()

ExUnit.start()
