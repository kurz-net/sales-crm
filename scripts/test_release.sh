# Environment
secret=$(mix phx.gen.secret)
export SECRET_KEY_BASE=$secret
export DATABASE_URL="ecto://"

# Start
MIX_ENV=prod mix phx.server

