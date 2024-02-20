#!/bin/bash

env_file="$bin_base/env.sh"
if [ -f "$env_file" ]; then
  source "$env_file"
fi

if [ -d "$CONFIG" ]; then
  echo "Using '$CONFIG' for configuration files"
else
    echo "CONFIG should be set to the directory where the secret containing the configuration is."
    exit -1
fi

missing_config=no
function load_config_var() {
  local -r var_name=$1; shift
  local -r file_name_var=$1; shift
  local -r short_description=$1; shift
  if [ "x$1" = "x" ]; then
    local -r optional=no
  else
    local -r optional=yes
  fi

  local -r file_name="$CONFIG/$file_name_var"
  if [ -f "$file_name" ]; then
    eval "$var_name='$(cat $file_name)'"
  else
    if [ "$optional" = "no" ] ; then
      echo "eee   Missing $file_name_var containing $short_description" 1>&2
      missing_config=yes
    fi
  fi
}
