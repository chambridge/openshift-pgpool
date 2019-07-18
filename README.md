# openshift-pgpool
Deployment steps for deploying Crunchy Data pgpool to OpenShift, with scripts for generating configuration data.

## Getting Started
This is a companion repository that works with [Crunchy Containers](https://github.com/CrunchyData/crunchy-containers) to deploy the *pgpool* container to act as a proxy pod within OpenShift for external databases like Amazon's RDS PostgreSQL.

Follow these steps to get started:

1. Clone this repository:
```
git clone git@github.com:chambridge/openshift-pgpool.git
```

2. Copy the `example.env.sh` file to `env.sh`:
```
cp example.env.sh env.sh
```

3. Update the necessary environment variables, `GOPATH`, `CCP_NAMESPACE`. The `GOPATH` should point to the parent directory of this repository.

4. Source the environment file:
```
. ./env.sh
```

5. Login to OpenShift cluster and project for deployment of pgpool
```
oc login
oc project myproject
```

6. Create `pgpool.conf` file with `create_pgpool_conf.sh` script:
```
./create_pool_passwd.sh SECRET_NAME HOSTNAME_KEY
```
This will create the `pgpool.conf` file in the `kube/pgpool/configs/` directory.


7. Create `pool_passwd` file with `create_pool_passwd.sh` script:
```
./create_pool_passwd.sh SECRET_NAME USERNAME_KEY PASSWORD_KEY
```
This will create the `pool_passwd` file in the `kube/pgpool/configs/` directory.


8. Create `server.pem` file with `create_server_pemfile.sh` script:
```
./create_server_pemfile.sh SECRET_NAME CACERT_KEY 
```
This will create the `server.pem` file in the `kube/pgpool/configs/` directory.

9. Clone the Crunchy Containers repository:
```
cd ..
git clone https://github.com/CrunchyData/crunchy-containers.git
cd crunchy-containers
```

9. Copy over setup files:
```
cd examples
cp -rf ../../openshift-pgpool/kube/ kube/
```

10. Deploy pgpool:
```
cd kube/pgpool/
./run_sslcacert.sh
```

## Working with deployed pgpool

You can now connect to the deployed `pgpool` pod which will essentially proxy the PostgreSQL database. Use `oc port-forward` to connect to the database.

Follow these steps to interact with deployed proxy:

1. Find the pod name for the deployed `pgpool`.
```
oc get pods -l name=pgpool -o name
```

2. Use port-forwarding to connect to the remote database.
```
oc port-forward [pod] 5432:5432 >/dev/null 2>&1 &
```

Now you can connect to remote database with either your local application or `psql`.