#!/usr/bin/env bash

if [ ! -z "${FLOWDOCK_API_TOKEN}" ]; then
  if [ "$1" == 'inbox' ]; then
    shift
    SUBJECT=$1;
    shift
    if [[ -z ${SUBJECT} || -z ${@} ]]; then
      echo "Inbox requires subject and body: $0 inbox SUBJECT BODY"
      exit
    fi
    # Visit https://www.flowdock.com/account/tokens for the flow API token.
    # Note that the external_user_name can not contain spaces
    curl "https://api.flowdock.com/v1/messages/team_inbox/$FLOWDOCK_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -d "{\"content\": \"$@\", \"subject\": \"${SUBJECT}\", \"from_address\": \"GitLab@gitlab.com\", \"source\": \"GitlabAutomation\", \"external_user_name\": \"GitlabAutomation\", \"tags\": [\"ci\"]}"
  else
    curl "https://api.flowdock.com/v1/messages/chat/$FLOWDOCK_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -d "{\"content\": \"$@\", \"external_user_name\": \"GitlabAutomation\", \"tags\": [\"ci\"]}"
  fi
else
  echo "FLOWDOCK_API_TOKEN not defined, skipping notification"
  echo "Set FLOWDOCK_API_TOKEN in the CI/CD settings to enable notifications"
fi
