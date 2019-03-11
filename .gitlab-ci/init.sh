#!/usr/bin/env bash
# Script used in GitLab CI to build the site from scratch.
# Should match the .octane/init.sh script used for Docksal local setup.

#cd /var/www
composer self-update
ls -al
rm -rf build/docroot/core
ls -al build/docroot

if [ -e "./bin/particle" ]; then
  # Install Particle
  ./bin/particle
fi

# Initial build of site.
./bin/build "$@"

