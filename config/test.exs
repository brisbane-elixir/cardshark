use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :card_shark, CardShark.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :card_shark, CardShark.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "card_shark_test",
  size: 1,
  max_overflow: 0
