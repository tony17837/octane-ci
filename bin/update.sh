#!/usr/bin/env bash
# Update the site.
# Runs in the web container, NOT the build container.
# So ONLY use drush commands here, or other tools available in web container.

DRUPAL_DB=`drush status --fields=db-hostname`
if [ ! -z "$DRUPAL_DB" ]; then

  # Clear cache before updates.
  echo "Clearing cache..."
  drush cr

  # Run any core or module update hooks.
  echo "Running updates..."
  drush updb -y

  # Import configuration. This will overwrite any local changes in your DB.
  echo "Importing config..."
  drush config-import -y

  # Need a clear-cache here in case new configuration is needed in theme.
  echo "Clearing cache..."
  drush cr

else
  # If we don't have a Drupal site, install it now.
  ./install.sh
fi
