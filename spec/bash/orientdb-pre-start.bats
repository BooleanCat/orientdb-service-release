#!/usr/bin/env bats

PROJECT_ROOT=${PROJECT_ROOT:-"../.."}
ASSETS_DIR="${PROJECT_ROOT}/spec/bash/assets"

source "${PROJECT_ROOT}/jobs/orientdb/templates/pre-start"

@test "LOG_DIR is correct" {
  [ "${LOG_DIR}" = "/var/vcap/sys/log/orientdb" ]
}

@test "ORIENTDB_USER is correct" {
  [ "${ORIENTDB_USER}" = "vcap" ]
}

@test "ORIENTDB_INSTALL_DIR is correct" {
  [ "${ORIENTDB_INSTALL_DIR}" = "/var/vcap/packages/orientdb" ]
}

@test "ORIENTDB_TEMPLATE is correct" {
  [ "${ORIENTDB_TEMPLATE}" = "/var/vcap/packages/orientdb/bin/orientdb.sh.template" ]
}

@test "template_orientdb_script" {
  local expected="$( cat "${ASSETS_DIR}/expected-orientdb.sh" )"
  run template_orientdb_script "${ASSETS_DIR}/simple-orientdb.sh" "/foo/bar" "pikachu"

  [ "$status" -eq 0 ]
  [ "$output" = "$expected" ]
}

@test "template_orientdb_script returns 1 if not called with 3 arguments" {
  run template_orientdb_script "${ASSETS_DIR}/simple-orientdb.sh" "/foo/bar"

  [ "$status" = 1 ]
  [ "$output" = "expected 3 arguments with call to template_orientdb_script" ]
}
