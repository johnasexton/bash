#!/usr/local/bin/bash -x
export SPANNERSECRETNAME=spansecret
export NAMESPACE=jenkins
export ID=<GCP_UID>
export KEYNAME=spanner.json
export KEYPATH=/Users/${ID}/workspace/ikt
export KEYFILE=<KEY>.json

# apply secret to ${NAMESPACE}
echo "kubectl create secret generic ${SPANNERSECRETNAME} \
--from-file=${KEYNAME}=${KEYPATH}/${KEYFILE} \
-n ${NAMESPACE}"

kubectl create secret generic ${SPANNERSECRETNAME}  \
 --from-file=${KEYNAME}=${KEYPATH}/${KEYFILE} \
-n ${NAMESPACE}
