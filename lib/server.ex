require Logger

defmodule EventbriteApi.Server do
  def start_link(opts \\ [port: 4000, compress: true]) do
    if port = System.get_env("PORT") do
      opts = Keyword.put(opts, :port, String.to_integer(port))
    end

    Logger.info "Starting Cowboy on port #{opts[:port]}"
    Plug.Adapters.Cowboy.http(EventbriteApi.Router, [], opts)
  end
  
end
