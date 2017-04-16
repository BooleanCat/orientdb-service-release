#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname $DIR )"

basht --version > /dev/null 2>&1
if [[ "$?" -ne 0 ]]; then
  echo "basht is required to run tests" >&2
  exit 1
fi

basht $PROJECT_ROOT/spec/bash/*.bash
