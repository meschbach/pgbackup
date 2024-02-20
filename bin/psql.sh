#!/bin/sh

db_override=$1; shift

set -e
bin_base=$( cd $(dirname $0) && pwd )
source "$bin_base/common.sh"
source "$bin_base/common.s3.sh"
source "$bin_base/common.pg.sh"

if [ "$missing_config" = "yes" ]; then
  exit -1
else
  echo "Configuration loaded."
fi

if [ "x$db_override" !=  "x" ]; then
  PGDATABASE="$db_override"
fi

VERBOSITY=verbose psql  --host=$PGHOST --user=$PGUSER --dbname=$PGDATABASE
