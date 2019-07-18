#!/bin/sh
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 SECRET_NAME USERNAME_KEY PASSWORD_KEY" >&2
  exit 1
fi

username=`oc get secrets $1 --template={{.data.$2}} | base64 - --decode`
password=`oc get secrets $1 --template={{.data.$3}} | base64 - --decode`

echo "$username:$password" > kube/pgpool/configs/pool_passwd

echo "Create pool_passwd in kube/pgpool/configs/ directory."