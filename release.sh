kill -9 $(lsof -t -i:${APP_PORT})
kill -9 $(lsof -t -i:${APP_PORT_NOT_CERT})
source .env
mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
PORT=${APP_PORT} MIX_ENV=prod elixir --erl "-detached" -S mix phx.server

