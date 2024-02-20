##
## Postgres variables
##
load_config_var PGHOST "pg_host" "Postgres Host"
load_config_var PGPORT "pg_port" "Postgres Port" optional
if [ "x$PGPORT" = "x" ]; then
  PGPORT=5432
fi
load_config_var PGUSER "pg_user" "Postgres User"
# todo: ideally this uses PGPASSFILE instead
load_config_var PGPASSWORD "pg_password" "Postgres Password"; export PGPASSWORD
load_config_var PGDATABASE "pg_database" "Postgres Database to backup"

#
# TODO: ideally we use the PGPASSFILE mechanism however for some reason psql and pg_dump are refusing to extract the
# password from the file.  Using PGPASSWORD is not as secure but works for now
#
#export PGPASSFILE=$PWD/pgpass
#if [ -f "$PGPASSFILE" ]; then
#  rm $PGPASSFILE
#fi
#cat >$PGPASSFILE <<EOF
#$PGHOST:$PGPORT:$PGDATABASE:$PGUSER:$PGPASSWORD_VAR
#EOF
#chmod 0600 $PGPASSFILE
#cat $PGPASSFILE
