defmodule Canine.Mixfile do
  use Mix.Project

  def project do
    [
      app: :canine,
      version: "0.0.1",
      elixir: "~> 1.7.3",
      erlang: "20.3",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      docs: [main: "PaymentService", extras: ["README.md"]],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Canine.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:excoveralls, "~> 0.9.2", only: :test},
      {:hound, "~> 1.0"},
    ]
  end
end
