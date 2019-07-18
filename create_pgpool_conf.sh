#!/bin/sh
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 SECRET_NAME HOSTNAME_KEY USERNAME_KEY PASSWORD_KEY" >&2
  exit 1
fi

hostname=`oc get secrets $1 --template={{.data.$2}} | base64 - --decode`
username=`oc get secrets $1 --template={{.data.$3}} | base64 - --decode`
password=`oc get secrets $1 --template={{.data.$4}} | base64 - --decode`

if [ -f kube/pgpool/configs/pgpool.conf ]; then
  rm kube/pgpool/configs/pgpool.conf
fi

sed "s/'master'/'$hostname'/g" kube/pgpool/configs/example.pgpool.conf | sed "s/'testuser'/'$username'/g" | sed "s/'password'/'${password//&/\\&}'/g" > kube/pgpool/configs/pgpool.conf
# sed "s/'password'/'$password'/g" kube/pgpool/configs/pgpool.conf > kube/pgpool/configs/pgpool.conf

echo "Create pgpool.conf in kube/pgpool/configs/ directory."