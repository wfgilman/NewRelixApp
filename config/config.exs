# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :new_relix_app,
  ecto_repos: [NewRelixApp.Repo]

# Configures the endpoint
config :new_relix_app, NewRelixApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pK3UIbXBGQoAwWRhnWSw5ljx2iCnGxX18BPwnXDbFbljffX6CU9QJTCTkzz4NJXv",
  render_errors: [view: NewRelixApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NewRelixApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
