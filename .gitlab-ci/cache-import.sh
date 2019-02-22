#!/usr/bin/env bash
# Script used in GitLab CI to import cache from build.
# This runs within the Dockerfile.web image in GitLab.
# Run via: docker run --rm -v ${PWD}:/build IMAGENAME /build/.gitlab-ci/cache-import.sh

cd /var/www

# /build is the local host files directory.
# Copy any files needed from the container into /build.
# For example, vendor, node_modules, etc.

rsync -au . /build
# Make directories writeable so docker can access.
find /build -type d -exec chmod a+w {} \;
# Make files writeable so docker can access.
find /build -type f -exec chmod a+w {} \;

ls -al /build
ls -al /build/vendor
ls -al /build/build/docroot
