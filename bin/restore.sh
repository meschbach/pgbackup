#!/bin/bash

set -e
bin_base=$( cd $(dirname $0) && pwd )
source "$bin_base/common.sh"
source "$bin_base/common.s3.sh"
source "$bin_base/common.pg.sh"

set -xe

aws --no-verify-ssl s3 $endpoint_flag cp "s3://$s3_bucket$s3_target_object" - |gunzip|\
 VERBOSITY=verbose psql  --host=$PGHOST --user=$PGUSER --dbname=$PGDATABASE
