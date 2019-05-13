#!/usr/bin/env bash
## First time project setup.
## Called from both GitLab CI and via "fin init" for new projects.

set -e

# Install Particle theme.
.octane/particle.sh

