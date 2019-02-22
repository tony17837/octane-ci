#!/usr/bin/env bash
# Script used in GitLab CI to import cache from build.
# This runs within the Dockerfile.web image in GitLab.
# Run via: docker run --rm -v ${PWD}:/build IMAGENAME /build/.gitlab-ci/cache-import.sh

cd /var/www

# /build is the local host files directory.
# Copy any files needed from the container into /build.
# For example, vendor, node_modules, etc.

# Only copy cached vendor if project doesn't already have one in repo.
if [[ -e vendor  && ! -e /build/vendor ]]; then
  cp -R vendor /build
  # Make directories writeable so docker can access.
  find /build/vendor -type d -exec chmod 777 {} \;
  # Make files writeable so docker can access.
  find /build/vendor -type f -exec chmod 666 {} \;
  ls -al /build
  ls -al /build/vendor/composer/
  ls -al /build/vendor/composer/bin
fi

# Only copy cached composer.lock if project doesn't already have one in repo.
if [[ -e composer.lock && ! -e /build/composer.lock ]]; then
  cp composer.lock /build
fi

# find . -type d -exec chmod 777 {} \;
