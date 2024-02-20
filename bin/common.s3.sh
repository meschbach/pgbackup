#
# AWS configuration variables
#
load_config_var endpoint_flag_config "s3_endpoint" "S3 endpoint" optional
if [ "x$endpoint_flag_config" != "x" ]; then
  endpoint_flag="--endpoint $endpoint_flag_config"
fi

## TODO: created or directly pull in AWS config file so these are not directly exposed
load_config_var AWS_ACCESS_KEY_ID "aws_access_key_id" "AWS API Token" && export AWS_ACCESS_KEY_ID
load_config_var AWS_SECRET_ACCESS_KEY "aws_secret_access_key" "AWS API Token secret" && export AWS_SECRET_ACCESS_KEY
load_config_var maybe_region "aws_default_region" "AWS default region" optional
if [ "x$maybe_region" != "x" ]; then
  export AWS_DEFAULT_REGION="$maybe_region"
fi

load_config_var s3_bucket "s3_bucket" "S3 Bucket"
load_config_var s3_target_object "s3_target_object" "Object to store as"
