#!/usr/bin/env bash
# Script used in GitLab CI to build the site from scratch.
# Should match the .octane/init.sh script used for Docksal local setup.

#cd /var/www
ls -al
rm -rf build/docroot/core
ls -al build/docroot

# Install Particle
./bin/particle

# Initial build of site.
./bin/build "$@"

