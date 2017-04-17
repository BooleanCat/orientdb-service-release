#!/usr/bin/env bats

source ../../jobs/orientdb/templates/pre-start

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
  local templated="$( template_orientdb_script "$DIR/assets/simple-orientdb.sh" "/foo/bar" "pikachu" )"
  local expected="$( cat "$DIR/assets/expected-orientdb.sh" )"

  [ "${templated}" = "${expected}" ]
}

@test "template_orientdb_script returns 1 if not called with 3 arguments" {
  run template_orientdb_script "${DIR}/assets/simple-orientdb.sh" "/foo/bar"
  [ $status = 1 ]
}
