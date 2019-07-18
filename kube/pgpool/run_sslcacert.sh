#!/bin/bash

source ${CCPROOT}/examples/common.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh


${CCP_CLI?} create --namespace=${CCP_NAMESPACE?} secret generic pgpool-secrets \
	--from-file=$DIR/configs/pool_hba.conf \
	--from-file=$DIR/configs/pgpool.conf \
	--from-file=$DIR/configs/pool_passwd \
	--from-file=$DIR/configs/server.pem

${CCP_CLI?} label --namespace=${CCP_NAMESPACE?} secret \
    pgpool-secrets cleanup=${CCP_NAMESPACE?}-pgpool

expenv -f $DIR/pgpool.json | ${CCP_CLI?} create --namespace=${CCP_NAMESPACE?} -f -
