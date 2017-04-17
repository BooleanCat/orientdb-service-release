#!/usr/bin/env bash
set -e

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PROJECT_ROOT="$( dirname "${DIR}" )"

if ! bats --version >/dev/null 2>&1; then
  echo "bats is required to run tests" >&2
  exit 1
fi

pushd "${PROJECT_ROOT}/spec/bash" >/dev/null
  bats .
popd >/dev/null
