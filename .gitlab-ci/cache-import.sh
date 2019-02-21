#!/usr/bin/env bash
# Script used in GitLab CI to import cache from build.
# This runs within the Dockerfile.web image in GitLab.
# Run via: docker run --rm -v ${PWD}:/build IMAGENAME /build/.gitlab-ci/cache-import.sh

cd /var/www

# /build is the local host files directory.
# Copy any files needed from the container into /build.
# For example, vendor, node_modules, etc.
cp -R vendor /build
