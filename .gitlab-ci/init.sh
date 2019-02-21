#!/usr/bin/env bash
# Script used in GitLab CI to build the site from scratch.
# Should match the .octane/init.sh script used for Docksal local setup.

echo "In build script"
ls -al
ls -al vendor

printf "$INFO_SLUG Installing Particle...\n"
#./bin/particle

printf "$INFO_SLUG Building site...\n"
# Initial build of site.
#./bin/build "$@"

