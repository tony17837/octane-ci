#!/usr/bin/env bash
# Called from .gitlab-ci.yml when the build cache should be loaded.
# Build cache copied from the previous build container

# Login so we can push images to the registry
docker login -u gitlab-ci-token -p $CI_JOB_TOKEN $CI_REGISTRY
# Grab cached files from previous build.
docker run --rm -v ${PWD}:/build ${WEB_IMAGE}:${CI_COMMIT_REF_SLUG} /build/.gitlab-ci/cache-import.sh
