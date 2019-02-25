#!/usr/bin/env bash

# Taken from https://github.com/zlabjp/kubernetes-scripts/blob/master/wait-until-pods-ready
# Modified by mpotter 2/25/2019 to take namespace argument.
#
# Copyright 2017, Z Lab Corporation. All rights reserved.
# Copyright 2017, Kubernetes scripts contributors
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

# Usage: wait-until-pods-ready NAMESPACE PERIOD INTERVAL
# NAMESPACE defaults to current
# PERIOD defaults to 120
# INTERVAL defaults to 10

NAMESPACE="$1"

set -e

function __is_pod_ready() {
  [[ "$(kubectl get pod "$1" ${NAMESPACE} -o 'jsonpath={.status.conditions[?(@.type=="Ready")].status}')" == 'True' ]]
}

function __pods_ready() {
  local pod

  [[ "$#" == 0 ]] && return 0

  for pod in $pods; do
    __is_pod_ready "$pod" || return 1
  done

  return 0
}

function __wait-until-pods-ready() {
  local period interval i pods

  period="${2:-120}"
  interval="${3:-10}"

  if [[ ${NAMESPACE} != "" ]]; then
    NAMESPACE="-n ${NAMESPACE}"
  fi

  kubectl get pods ${NAMESPACE}

  for ((i=0; i<$period; i+=$interval)); do
    pods="$(kubectl get pods ${NAMESPACE} -o 'jsonpath={.items[*].metadata.name}')"
    if __pods_ready $pods; then
      return 0
    fi

    echo "Waiting for pods to be ready..."
    sleep "$interval"
  done

  echo "Waited for $period seconds, but all pods are not ready yet."
  kubectl get pods ${NAMESPACE}
  return 1
}

__wait-until-pods-ready $@
# vim: ft=sh :
