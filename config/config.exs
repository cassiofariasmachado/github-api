# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github,
  ecto_repos: [Github.Repo]

config :github, Github.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :github, GithubWeb.Auth.Guardian,
  issuer: "github",
  secret_key: "XWWyGS+0mCTgkR9zEIXqRQWk3nzcw4uxW/u5MMD2rEo5/ADeIZK33UH+338jArXO"

config :github, GithubWeb.Auth.Pipeline,
  module: GithubWeb.Auth.Guardian,
  error_handler: GithubWeb.Auth.ErrorHandler

# Configures the endpoint
config :github, GithubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qPxb8ntv8uMW8f6kZZ/tK8UY9EntFpdJSoKnVxe5XP2RvMkL4XMOSo3M9DB+zqUf",
  render_errors: [view: GithubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Github.PubSub,
  live_view: [signing_salt: "1aksZ+8O"]

config :github, Github.Client,
  adapter: Github.Client

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
