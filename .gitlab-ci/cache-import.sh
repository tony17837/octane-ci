#!/usr/bin/env bash
# Script used in GitLab CI to import cache from build.
# This runs within the Dockerfile.web image in GitLab.
# Run via: docker run --rm -v ${PWD}:/build IMAGENAME /build/.gitlab-ci/cache-import.sh

cd /var/www

# /build is the local host files directory.
# Copy any files needed from the container into /build.
# For example, vendor, node_modules, etc.

##rsync -au . /build
# Make directories writeable so docker can access.
##find /build -type d -exec chmod a+w {} \;
# Make files writeable so docker can access.
##find /build -type f -exec chmod a+w {} \;

# Only copy cached vendor if project doesn't already have one in repo.
if [[ -e vendor  && ! -e /build/vendor ]]; then
  cp -R vendor /build
  # Make directories writeable so docker can access.
  find /build/vendor -type d -exec chmod a+w {} \;
  # Make files writeable so docker can access.
  find /build/vendor -type f -exec chmod a+w {} \;
  ls -al /build
  ls -al /build/vendor/composer/
  ls -al /build/vendor/bin
  ls -al /build/vendor/squizlabs/php_codesniffer/bin
fi

# Only copy cached composer.lock if project doesn't already have one in repo.
if [[ -e composer.lock && ! -e /build/composer.lock ]]; then
  cp composer.lock /build
fi

# Only copy cached node_modules if project doesn't already have one in repo.
if [[ -e ${THEME_PATH}/node_modules && ! -e ${THEME_PATH}/node_modules ]]; then
  cp -R ${THEME_PATH}/node_modules /build/${THEME_PATH}/node_modules
  # Make directories writeable so docker can access.
  find /build/${THEME_PATH}/node_modules -type d -exec chmod a+w {} \;
  # Make files writeable so docker can access.
  find /build/${THEME_PATH}/node_modules -type f -exec chmod a+w {} \;
fi

# Only copy cached composer.lock if project doesn't already have one in repo.
if [[ -e ${THEME_PATH}/package-lock.json && ! -e ${THEME_PATH}/package-lock.json ]]; then
  cp ${THEME_PATH}/package-lock.json /build/${THEME_PATH}/package-lock.json
fi
