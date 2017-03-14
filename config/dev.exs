use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :new_relix_app, NewRelixApp.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]],
  instrumenters: [NewRelixApp.Instrument]


# Watch static and templates for browser reloading.
config :new_relix_app, NewRelixApp.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :new_relix_app, NewRelixApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "new_relix_app_dev",
  hostname: "localhost",
  pool_size: 10,
  loggers: [{Ecto.LogEntry, :log, []}, {NewRelixApp.Instrument, :log_entry, []}]

config :new_relix,
  license_key: System.get_env("NEW_RELIC_LICENSE_KEY"),
  plugin_guid: "com.mycompany.elixir",
  application_name: "NewRelixApp"
