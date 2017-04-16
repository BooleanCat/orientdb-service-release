#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$( dirname "${DIR}" )" )"

source $DIR/test_helpers
source $PROJECT_ROOT/jobs/orientdb/templates/pre-start

T_LOG_DIR_is_correct() {
  expect_to_equal "$LOG_DIR" "/var/vcap/sys/log/orientdb"
}

T_ORIENTDB_SCRIPT_is_correct() {
  expect_to_equal "$ORIENTDB_SCRIPT" "/var/vcap/packages/orientdb/bin/orientdb.sh"
}

T_configure_orientdb_script() {
  expect_to_equal \
    "$( configure_orientdb_script "$DIR/assets/simple-orientdb.sh" )" \
    "$( cat "$DIR/assets/expected-orientdb.sh" )"
}
