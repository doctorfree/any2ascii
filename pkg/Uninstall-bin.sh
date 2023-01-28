#!/bin/bash

ANY_FILES="usr/local/bin/any2a
           usr/local/bin/jp2a
           usr/local/share/man/man1/jp2a.1"
ANY_DIRS="usr/local/share/any2ascii
          usr/local/share/doc/any2ascii"

user=`id -u -n`

[ "${user}" == "root" ] || {
  echo "Uninstall-bin.sh must be run as the root user."
  echo "Use 'sudo ./Uninstall-bin.sh ...'"
  echo "Exiting"
  exit 1
}

rm -f ${ANY_FILES}
rm -rf ${ANY_DIRS}
