#!/usr/bin/env bash
##
# Fix File Permissions
#
# Some of the file permissions are broken or mis-aligned as a result
# of the various Docker and filesystem layers.
#
# Paths used align with the volume mappings in the docker-compose
# and build configuration files.
##

echo "Fixing up file permissions for development..."
echo "You can run this via 'fin exec bin/fix-perms.sh'"
set -x
# Ensure Apache manages the files directory.
chown -R apache:apache /var/www/src/sites/default/files
chmod 755 /var/www/src/sites/default/files
# Restore write access to Drupal settings directory after site install.
# This does not change the settings.php file itself, but helps avoid
# issues such as changes to settings across git branches.
chmod 755 /var/www/src/sites/default
