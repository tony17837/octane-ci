#!/usr/bin/env bash
# Install the Drupal site.

# Parse comment line arguments
CONFIRM=''
if [ "${CI}" = "true" ]; then
  CONFIRM='-y'
fi
while [[ $# -gt 0 ]]; do
  case $1 in
    -y)
    CONFIRM='-y'
    shift # past argument
    ;;
    *)    # profile name
    PROFILE="$1"
    shift # past argument
    ;;
  esac
done

if [ -z "$PROFILE" ]; then
  # Default install profile is Acquia Lightning.
  PROFILE="lightning"
fi

# Database connection for drush site-install.
# These variables are either set here:
#   Local Docksal: .docksal/docksal.env or
#   GitLab CI: .gitlab-ci/chart/templates/values.yaml
DB_URL="mysql://${MYSQL_USER:-user}:${MYSQL_PASSWORD:-user}@${MYSQL_HOST:-db}/${MYSQL_DATABASE:-default}"

cd /var/www/docroot
# Install Drupal site
if [ -e "src/config/default/system.site.yml" ]; then
  # If config exists, install using it.
  echo "Installing Drupal from existing config..."
  drush si --db-url=$DB_URL --account-pass="admin" --existing-config $CONFIRM
else
  # Otherwise install clean from profile.
  echo "Installing Drupal profile: ${PROFILE}..."
  drush si --db-url=$DB_URL --account-pass="admin" ${PROFILE} $CONFIRM
fi

# Fix permissions after install
cd ..
bin/fix-perms.sh

