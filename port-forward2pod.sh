#!/bin/bash
CLUSTER=ikt-nonprod-e4-01
PROJECT=initialkubetest
REGION=us-east1
APPLICATION=jenkins
HEALTHENDPOINT=/job/ikt-infra/job/docker

# set project
gcloud config set project ${PROJECT}
gcloud config list | grep ${PROJECT}

# set cluster
gcloud container clusters get-credentials ${CLUSTER} --region ${REGION} --project ${PROJECT}
kubectl config current-context

# find running workload during CI run
kubectl get pods -A | grep ${APPLICATION}

# find namespace
echo "export NAMESPACE=`kubectl get pods -A | grep ${APPLICATION} | awk '{print $1}'`"
export NAMESPACE=`kubectl get pods -A | grep ${APPLICATION} | awk '{print $1}'`

# find pod
echo "export PODNAME=`kubectl get pods -A | grep ${APPLICATION} | awk '{print $2}'`"
export PODNAME=`kubectl get pods -A | grep ${APPLICATION} | awk '{print $2}'`

# forward a local port:8888 to remote port:8080 direct to pod in namespace
export lport=8888
export rport=8080
export namespace=${NAMESPACE}
echo "kubectl port-forward ${PODNAME} ${lport}:${rport} -n ${NAMESPACE} & "
kubectl port-forward ${PODNAME} ${lport}:${rport} -n ${NAMESPACE} &

# test health endpoint
echo "RUNNING: curl -X GET http://localhost:8888/${APPLICATION}/${HEALTHENDPOINT}"
curl -X GET http://localhost:8888/${APPLICATION}/${HEALTHENDPOINT}
