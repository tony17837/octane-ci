#!/usr/bin/env bash
# Update the site.
# Runs in the web container, NOT the build container.
# So ONLY use drush commands here, or other tools available in web container.
YELLOW="\033[0;33m"
NORMAL="\033[0;0m"

DRUPAL_DB=`drush status --fields=db-hostname`
if [ ! -z "$DRUPAL_DB" ]; then

  # Clear cache before updates.
  printf "${YELLOW}Clearing cache...${NORMAL}\n"
  drush cr

  # Run any core or module update hooks.
  echo "${YELLOW}Running updates...${NORMAL}\n"
  drush updb -y

  # Import configuration. This will overwrite any local changes in your DB.
  echo "${YELLOW}Importing config...${NORMAL}\n"
  drush config-import -y

  # Need a clear-cache here in case new configuration is needed in theme.
  echo "${YELLOW}Clearing cache...${NORMAL}\n"
  drush cr

else
  # If we don't have a Drupal site, install it now.
  /var/www/bin/install.sh "$@"
fi
