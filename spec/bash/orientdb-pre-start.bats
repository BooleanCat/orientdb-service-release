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

@test "ensure_dir" {
  local some_dir="$( mktemp -d )"
  run ensure_dir "${some_dir}/foo" vcap:vcap

  [ "$status" -eq 0 ]
  [ "$( ls "$some_dir" )" = "foo" ]

  [ "$( owner_and_group "${some_dir}/foo" )" = "vcap:vcap" ]
}

@test "ensure_dir updates owner and group on existing dir" {
  local some_dir="$( mktemp -d )"
  [ "$( owner_and_group "$some_dir" )" = "root:root" ]

  run ensure_dir "$some_dir" vcap:vcap

  [ "$status" -eq 0 ]
  [ "$( owner_and_group "$some_dir" )" == "vcap:vcap" ]
}

owner_and_group() {
  local dir="$1"
  ls -ld "$dir" | awk '{print $3 ":" $4}'
}
