#!/usr/bin/env bash
#
# Rebuild the site and theme.  Used after doing "git pull" as part of
# daily workflow.
# Runs in the Build container, so all tools are available.

# Init the tools like npm within the cli container
source ~/.profile
YELLOW="\033[0;33m"
NORMAL="\033[0;0m"

CURRENT_DIR=${PWD}

printf "${YELLOW}Updating dependencies with Composer...${NORMAL}\n"
# Uncomment the following command if you want to continue building if patches
# fail to apply.
# COMPOSER_DISCARD_CHANGES=1 composer install --ansi
#
# Uncomment the following command if you want to ABORT building if patches
# fail to apply.
composer install --ansi --no-suggest

# Build the theme
printf "${YELLOW}Updating theme...${NORMAL}\n"
cd src/themes/particle && npm run build:drupal
cd ${CURRENT_DIR}

# Run updates, clear cache, etc
bin/update.sh
