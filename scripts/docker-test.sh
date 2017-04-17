#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "${DIR}" )"

pushd "$PROJECT_ROOT" > /dev/null
  docker run \
    -v "${PROJECT_ROOT}:/home/test/orientdb-service-release" \
    -w /home/test/orientdb-service-release \
    -i -t orientdb-service-release \
    scripts/test.sh
popd > /dev/null
