# Environment
secret=$(mix phx.gen.secret)
export SECRET_KEY_BASE=$secret
export DATABASE_URL="echo://"

MIX_ENV=prod mix ecto.drop
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix run ./priv/repo/seeds.exs
