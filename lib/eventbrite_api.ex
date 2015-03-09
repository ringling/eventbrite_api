defmodule EventbriteApi do
  use Application
  require Logger

  def start(_type, _args) do
    Dotenv.load!
    Logger.info "Starting EventbriteApi"
    EventbriteApi.Supervisor.start_link
  end
end
