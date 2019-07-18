#!/bin/sh
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 SECRET_NAME CACERT_KEY" >&2
  exit 1
fi

cacert=`oc get secrets rds-client-ca -o yaml | grep "rds-cacert"`
cacert=`echo ${cacert#  rds-cacert:}  | base64 - --decode`

echo "$cacert" > kube/pgpool/configs/server.pem

echo "Create server.pem in kube/pgpool/configs/ directory."