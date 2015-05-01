use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :card_shark, CardShark.Endpoint,
  secret_key_base: "NsWhas6ombZb1/LS4KBp8rfB52sO7LoP7NPOAuDgpmSXAGjoHImePCqlcjxf3Mqg"

# Configure your database
config :card_shark, CardShark.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_USERNAME"),
  password: System.get_env("DATABASE_PASSWORD"),
  database: System.get_env("DATABASE_DATABASE"),
  hostname: System.get_env("DATABASE_HOSTNAME"),
  size: 20 # The amount of database connections in the pool
