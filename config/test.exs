use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :new_relix_app, NewRelixApp.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :new_relix_app, NewRelixApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "new_relix_app_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
