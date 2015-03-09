defmodule EventbriteApi.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @eventbrite_cache :eventbrite_cache

  def init(:ok) do
    children = [
      worker(ConCache, [cache_opts, [name: @eventbrite_cache]]),
      worker(EventbriteApi.Server, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

  defp cache_opts do
    [
      ttl: :timer.hours(0.5),
      ttl_check: :timer.minutes(5)
    ]
  end

end
