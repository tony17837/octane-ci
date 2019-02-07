#!/usr/bin/env bash
# This runs within the CLI container, so all tools are available.

# Init the tools like npm within the cli container
source ~/.profile
YELLOW="\033[0;33m"
NORMAL="\033[0;0m"

# Install project dependencies from composer.
ls -al
ls -al vendor

printf "${YELLOW}Running Composer...${NORMAL}\n"
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
  printf "${YELLOW}Updating theme...${NORMAL}\n"
  cd ${THEME_PATH} && npm run build:drupal
else
  # If theme doesn't exist, go install Particle
  printf "${YELLOW}Installing Particle...${NORMAL}\n"
  bin/particle.sh
fi

cd ${CURRENT_DIR}

