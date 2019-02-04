#!/usr/bin/env bash
# Update the site.
# Runs in the web container, NOT the build container.
# So ONLY use drush commands here, or other tools available in web container.

# Clear cache before updates.
drush cr

# Run any core or module update hooks.
drush updb -y

# Import configuration. This will overwrite any local changes in your DB.
drush config-import -y

# Need a clear-cache here in case new configuration is needed in theme.
drush cr
