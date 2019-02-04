#!/usr/bin/env bash
# This runs within the CLI container, so all tools are available.

# Init the tools like npm within the cli container
source ~/.profile

# Install project requirements.
composer clear-cache
COMPOSER_PROCESS_TIMEOUT=2000 COMPOSER_DISCARD_CHANGES=1 composer install

# Build the theme
THEME_PATH="src/themes/particle"
if [ -e ${THEME_PATH} ]; then
  # Theme exists, so rebuild it.
  cd ${THEME_PATH} && npm run build:drupal
else
  # If theme doesn't exist, go install Particle
  bin/particle.sh
fi

cd ${CURRENT_DIR}

