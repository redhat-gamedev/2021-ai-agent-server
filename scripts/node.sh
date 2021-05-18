DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build -f Dockerfile.dev . -t shipwars-bot-server
docker run -e AI_SERVER_URL=$AI_SERVER_URL \
-e GAME_SERVER_URL=ws://shipwars-game-server:8181/game -e HUSKY_SKIP_HOOKS=1 \
--rm -p 8282:8282 -v "$(pwd)/src/:/usr/src/app/src/" \
--name=shipwars-bot-server shipwars-bot-server
