export GOPATH=$HOME/cdev        # set path to your new Go workspace
export GOBIN=$GOPATH/bin        # set bin path 
export PATH=$PATH:$GOBIN        # add Go bin path to your overall path
export CCP_BASEOS=centos7       # centos7 for Centos, rhel7 for Redhat
export CCP_PGVERSION=10         # The PostgreSQL major version
export CCP_PG_FULLVERSION=10.9
export CCP_VERSION=2.4.1
export CCP_IMAGE_PREFIX=crunchydata # Prefix to put before all the container image names
export CCP_IMAGE_TAG=$CCP_BASEOS-$CCP_PG_FULLVERSION-$CCP_VERSION   # Used to tag the images
export CCPROOT=$GOPATH/crunchy-containers    # The base of the clone github repo
export CCP_SECURITY_CONTEXT=""
export CCP_CLI=oc          # kubectl for K8s, oc for OpenShift
export CCP_NAMESPACE=myproject       # Change this to whatever namespace/openshift project name you want to use
