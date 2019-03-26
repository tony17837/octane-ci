#!/usr/bin/env bash
# Scaffold the Octane-based project.
# This script is called by the Docksal "fin init" to set up local environment.
# This script runs within the Build container, so all tools are available.

set -e

if [ -e "./bin/particle" ]; then
  printf "$INFO_SLUG Installing Particle...\n"
  # Install Particle
  ./bin/particle
fi

printf "$INFO_SLUG Building site...\n"
# Initial build of site.
./bin/build "$@"
