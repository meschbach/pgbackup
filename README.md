# pgbackup
Tooling for automated backup and restoring in Kubernetes.  Each of the following commands takes a secret mounted in the
file system as configuration for their actions.

## Commands
* [bin/backup.sh](bin/backup.sh) will create a gzipped compressed SQL restore file in an S3-like store.
* [bin/restore.sh](bin/restore.sh) will take a gzipped compressed SQL restore file from S3 and run it against the
specified database.  The database and user must exist already.
* [bin/psql.sh](bin/psql.sh) is a utility to connect to the target database for debugging purposes.

## Secret Layout
Checkout [examples/backup](examples/backup) for a complete example.  The directory is designed to be keys in a
kubernetes secret mounted into the pod.

AWS Related keys:
* `aws_access_key_id` - Access key to connect to S3 with
* `aws_secret_access_key` - Access key secret to authenticate with
* (optional) `aws_default_region` - Region of the target bucket
* (optional) `s3_endpoint` - S3 Endpoint to contact.  Defaults to AWS default. 
* `s3_bucket` - S3 Bucket to store or retrieve the artifact
* `s3_target_object` - S3 key within the bucket to store or retrieve
* (optional) `s3_object_dated` - Sends the `s3_target_object` through `date` as a formatted string, storing the object
as a result.

Postgres related keys:
* `pg_host` - Host of the Postgres database
* (optional) `pg_port` - If running on a port other than standard.  Defaults to the standard port 5432
* `pg_user` - User to connect as
* `pg_password` - Password to authenticate the user as
* `pg_database` - Target database to perform the operation against.

# Change Log
`v0.2.0` - Adds `s3_object_dated` so running as a `CronJob` in k8s is easier to keep a number of backups.
`v0.1.0` - Initial working release
