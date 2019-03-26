#!/usr/bin/env bash

RELEASE_TIMEOUT=${RELEASE_TIMEOUT:-300}

if [ -z "${RELEASE_NAME}" ]; then
  echo "RELEASE_NAME must be specified in the environment"
  echo "Example: RELEASE_NAME=project-release $0 COMMAND_TO_EXECUTE"
  exit 1
fi

CONTAINER=""
if [[ $1 == "web" || $1 == "cli" ]]; then
  CONTAINER="-c $1"
  shift
fi

if [ -z "$1" ]; then
  echo "No command to execute found"
  echo "Usage: $0 [web|cli] COMMAND_TO_EXECUTE"
  exit 1
fi

# Set namespace from KUBE_NAMESPACE if defined.
NAMESPACE=""
if [ ! -z "${KUBE_NAMESPACE}" ]; then
  NAMESPACE="-n ${KUBE_NAMESPACE}"
fi

PODNAME=$(kubectl get pods -o name ${NAMESPACE} -l release=$RELEASE_NAME,webcontainer=true | cut -f2 -d/)

echo "Executing $@ in ${PODNAME} for release ${RELEASE_NAME}"

if [ ! -z "${PODNAME}" ]; then
  kubectl --request-timeout=${RELEASE_TIMEOUT} exec ${NAMESPACE} ${CONTAINER} ${PODNAME} -- $@
else
  echo 'Could not determine pod to execute command in'
  echo RELEASE_NAME=$RELEASE_NAME
  set | grep KUBE
  kubectl get pods ${NAMESPACE}
  exit 1;
fi
