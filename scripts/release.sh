# Environment
secret=$(mix phx.gen.secret)
export SECRET_KEY_BASE=$secret
export DATABASE_URL="ecto://"

# Initial Setup
mix deps.get --only-prod
MIX_ENV=prod mix compile

# Install / update  JavaScript dependencies
npm install --prefix ./assets

# Compile assets
npm run deploy --prefix ./assets
mix phx.digest

# Release
MIX_ENV=prod mix release --force --overwrite

