use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :card_shark, CardShark.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

if !System.get_env("DATABASE_URL") do
  System.put_env "DATABASE_URL", "postgres://#{System.get_env("USER")}:@localhost/card_shark_test"
end
# Configure your database
config :card_shark, CardShark.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox
