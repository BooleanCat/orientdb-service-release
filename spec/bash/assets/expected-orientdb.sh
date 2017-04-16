#!/bin/sh
# OrientDB service script
#
# Copyright (c) Orient Technologies LTD (http://www.orientechnologies.com)

# chkconfig: 2345 20 80
# description: OrientDb init script
# processname: orientdb.sh

# You have to SET the OrientDB installation directory here
ORIENTDB_DIR=/var/vcap/packages/orientdb
ORIENTDB_USER=vcap

usage() {
	echo "Usage: `basename $0`: <start|stop|status>"
	exit 1
}
