use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :canine, CanineWeb.Endpoint,
  http: [port: 4001],
  server: true

config :canine, region: System.get_env("REGION")

config :hound, browser: "chrome"

# Print only warnings and errors during test
config :logger, level: :warn
