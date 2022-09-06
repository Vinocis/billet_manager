# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :billet_manager,
  ecto_repos: [BilletManager.Repo]

config :billet_manager, BilletManager.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "db"

# Configures the endpoint
config :billet_manager, BilletManagerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BilletManagerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BilletManager.PubSub,
  live_view: [signing_salt: "ICdDPixD"]

config :money,
  default_currency: :BRL,
  separator: ".",
  delimiter: ","

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :billet_manager, BilletManager.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
