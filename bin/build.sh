#!/usr/bin/env bash

# Install project requirements.
composer clear-cache
COMPOSER_PROCESS_TIMEOUT=2000 COMPOSER_DISCARD_CHANGES=1 composer install
