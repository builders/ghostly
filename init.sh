#!/bin/bash
set -e

if [ ! -d themes ]; then
(
  mkdir themes
  cd themes
  git clone https://github.com/TryGhost/Casper.git casper
)
fi

if [ ! -d .data ]; then
(
  mkdir .data
)
fi

if [ ! -d logs ]; then
(
  mkdir logs
)
fi

if [ ! -f .data/ghost-local.db ]; then
(
  cd node_modules/ghost
  knex-migrator init
  mv content/data/ghost-dev.db ~/.data/ghost-local.db
)
fi

jq ".url=\"https://$PROJECT_DOMAIN.glitch.me\"" config.development.json.base > config.development.json
