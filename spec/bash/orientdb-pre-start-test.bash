#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$( dirname "${DIR}" )" )"

source $DIR/test_helpers
source $PROJECT_ROOT/jobs/orientdb/templates/pre-start

T_LOG_DIR_is_correct() {
  expect_to_equal "${LOG_DIR}" "/var/vcap/sys/log/orientdb"
}

T_ORIENTDB_USER_is_correct() {
  expect_to_equal "${ORIENTDB_USER}" "vcap"
}

T_ORIENTDB_INSTALL_DIR_is_correct() {
  expect_to_equal "${ORIENTDB_INSTALL_DIR}" "/var/vcap/packages/orientdb"
}

T_ORIENTDB_TEMPLATE_is_correct() {
  expect_to_equal "${ORIENTDB_TEMPLATE}" "/var/vcap/packages/orientdb/bin/orientdb.sh.template"
}

T_configure_orientdb_script() {
  expect_to_equal \
    "$( template_orientdb_script "$DIR/assets/simple-orientdb.sh" "/foo/bar" "pikachu" )" \
    "$( cat "$DIR/assets/expected-orientdb.sh" )"
}
