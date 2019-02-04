#!/usr/bin/env bash
# Install Particle

THEME_PATH="src/themes/particle"
# Only download particle theme if it doesn't already exist.
if [ ! -e ${THEME_PATH} ]; then
  # Install latest Particle theme
  npx phase2/create-particle ${THEME_PATH}
  # @TODO: Remove this once Particle removes Husky.
  # Need to remove the default git hooks added by Husky from Particle.
  # They interfere with project hooks and with Drupal config import/export.
  rm -rf .git/hooks
fi

