#!/usr/bin/env bash
# Scaffold the Octane-based project.
# This script runs within the Build container, so all tools are available.

printf "$INFO_SLUG Building site...\n"

# Only download particle theme if it doesn't already exist.
if [ ! -e ${THEME_PATH} ]; then
  printf "$INFO_SLUG Installing Particle...\n"
  # Install latest Particle theme
  npx phase2/create-particle ${THEME_PATH}
  # @TODO: Remove this once Particle removes Husky.
  # Need to remove the default git hooks added by Husky from Particle.
  # They interfere with project hooks and with Drupal config import/export.
  rm -rf .git/hooks
fi

printf "$INFO_SLUG Building site...\n"
# Initial build of site.
./bin/build "$@"

