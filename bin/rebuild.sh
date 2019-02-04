#!/usr/bin/env bash
#
# Rebuild the site and theme.  Used after doing "git pull" as part of
# daily workflow.
# Runs in the Build container, so all tools are available.

CURRENT_DIR=${PWD}

# Uncomment the following command if you want to continue building if patches
# fail to apply.
# COMPOSER_DISCARD_CHANGES=1 composer install
#
# Uncomment the following command if you want to ABORT building if patches
# fail to apply.
composer install

# Build the theme
cd src/themes/particle && npm run build:drupal
cd ${CURRENT_DIR}

# Run updates, clear cache, etc
bin/update.sh
