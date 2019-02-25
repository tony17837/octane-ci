#!/usr/bin/env bash
# Sets chart values from environment variables.

# Read environment variables from .env file, skipping comments.
export $(grep -v '^#' .env | xargs)

# Output the environment variables into YAML format.
echo "env:"
echo "  projectName: ${PROJECT_NAME}"
echo "  profile: ${PROFILE}"
echo "  docroot: /var/www/${DOCROOT}"
echo "  projectDir: ${PROJECT_DIR}"
echo "  configPath: ${CONFIG_PATH}"
echo "  themePath: ${THEME_PATH}"
echo "volumeMounts:"
echo "  cmsfiles:"
echo "    mountPath: /var/www/${DOCROOT}/sites/default/files"
echo "mariadb:"
echo "  mariadbUser: ${MYSQL_USER}"
echo "  mariadbPassword: ${MYSQL_PASSWORD}"
echo "  mariadbDatabase: ${MYSQL_DATABASE}"

