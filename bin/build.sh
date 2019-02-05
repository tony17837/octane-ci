#!/usr/bin/env bash
# This runs within the CLI container, so all tools are available.

# Init the tools like npm within the cli container
source ~/.profile

# Install project dependencies from composer.

# Uncomment the following command if you want to continue building if patches
# fail to apply.
COMPOSER_PROCESS_TIMEOUT=2000 COMPOSER_DISCARD_CHANGES=1 composer install --ansi --no-suggest
#
# Uncomment the following command if you want to ABORT building if patches
# fail to apply.
# COMPOSER_PROCESS_TIMEOUT=2000 composer install --ansi --no-suggest

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

