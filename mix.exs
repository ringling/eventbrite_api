defmodule EventbriteApi.Mixfile do
  use Mix.Project

  def project do
    [app: :eventbrite_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpotion, :dotenv, :poison, :con_cache, :cowboy, :plug],
    mod: {EventbriteApi, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:con_cache, "~> 0.6.0"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 0.9.0"},
      {:dotenv, "~> 0.0.4"},
      {:poison, github: "devinus/poison"},
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
      {:httpotion, "~> 2.0.0"},
      {:shouldi, only: :test},
      {:mock, only: :test}
    ]
  end
end
