#!/bin/bash

set -e
bin_base=$( cd $(dirname $0) && pwd )
source "$bin_base/common.sh"
source "$bin_base/common.s3.sh"
load_config_var s3_target_dated "s3_object_dated" "When 'yes' interprets s3_target_object as a date formatted to be sent through date(1)" optional
source "$bin_base/common.pg.sh"

if [ "$missing_config" = "yes" ]; then
  exit -1
else
  echo "Configuration loaded."
fi

if [ "$s3_target_dated" = "yes" ]; then
  s3_target_object=$(date "+$s3_target_object")
fi

pg_dump --verbose --no-password --no-owner \
  --compress=9 \
  --host=$PGHOST --user=$PGUSER --dbname=$PGDATABASE |\
aws --no-verify-ssl s3 $endpoint_flag cp - "s3://$s3_bucket$s3_target_object"
