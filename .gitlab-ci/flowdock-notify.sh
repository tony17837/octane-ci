#!/usr/bin/env bash

if [ ! -z "${FLOWDOCK_API_TOKEN}" ]; then
  # Note that the external_user_name can not contain spaces
  curl https://api.flowdock.com/v1/messages/chat/$FLOWDOCK_API_TOKEN \
    -H 'Content-Type: application/json' \
    -d "{\"content\": \"$@\", \"external_user_name\": \"GitlabAutomation\", \"tags\": [\"ci\"]}"
else
  echo "FLOWDOCK_API_TOKEN not defined, skipping notification"
  echo "Set FLOWDOCK_API_TOKEN in the CI/CD settings to enable notifications"
fi
