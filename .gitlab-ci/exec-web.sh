#!/usr/bin/env bash

RELEASE_TIMEOUT=${RELEASE_TIMEOUT:-300}

if [ -z "${RELEASE_NAME}" ]; then
  echo "RELEASE_NAME must be specified in the environment"
  echo "Example: RELEASE_NAME=project-release $0 COMMAND_TO_EXECUTE"
  exit 1
fi

if [ -z "$1" ]; then
  echo "No command to execute found"
  echo "Usage: $0 COMMAND_TO_EXECUTE"
  exit 1
fi

PODNAME=$(kubectl get pods -o name -l release=$RELEASE_NAME,webcontainer=true | cut -f2 -d/)

echo "Executing $@ in ${PODNAME} for release ${RELEASE_NAME}"

if [ ! -z "${PODNAME}" ]; then
  kubectl --request-timeout=${RELEASE_TIMEOUT} exec ${PODNAME} -- $@
else
  echo 'Could not determine pod to execute command in'
  echo RELEASE_NAME=$RELEASE_NAME
  set | grep KUBE
  kubectl get pods
  exit 1;
fi
