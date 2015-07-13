# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :card_shark, CardShark.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "R1Z849SY8rNMr8S0H7XhyM6syhpofPaJkdI1WFQC0eXAyFaR84RCmg9FqpZ/N1is",
  debug_errors: false,
  pubsub: [name: CardShark.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :card_shark, CardShark.Repo,
  extensions: [{CardShark.Extensions.Json, library: Poison}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
