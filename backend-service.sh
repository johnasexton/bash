#!/usr/local/bin/bash

# VARIABLES
export PROJECT=initialkubetest
export GKECLUSTER=ikt-e1-01
export CLUSTER_CONTEXT=gke_initialkubetest_us-east1-b_ikt-e1-01
export CNAME=ikt
export GCLBNAME=gclb-${CNAME}
export HEALTHCHECKNAME=${CNAME}-hc
export BACKENDSERVICENAME=${CNAME}-be
export IPNAME=${CNAME}-ip
export PORTNAME=http
export PROTOCOL=HTTP
export PORTNUMBER=80
export IAPENABLE=disabled

# set gcp-project scope
echo "gcloud config set project ${PROJECT}"

# set gke context
# echo "gcloud --project ${PROJECT} container clusters get-credentials ${GKECLUSTER} --zone ${zone}
echo "kubectx ${CLUSTER_CONTEXT}"

# create static-ip for GCLB load balancer
echo "gcloud compute addresses create ${IPNAME} --project=${PROJECT} --global"

# create health check
echo "gcloud compute health-checks create ${PROTOCOL} ${HEALTHCHECKNAME} \
--project=${PROJECT} \
--port=${PORTNUMBER} \
--request-path=/healthz \
--proxy-header=NONE \
--check-interval=10 \
--timeout=5 \
--unhealthy-threshold=3 \
--healthy-threshold=2"

# create iap enabled backend service
echo "gcloud compute backend-services create ${BACKENDSERVICENAME} \
--project=${PROJECT} \
--affinity-cookie-ttl=0 \
--connection-draining-timeout=300 \
--no-enable-cdn \
--health-checks=${HEALTHCHECKNAME} \
--iap=${IAPENABLE} \
--port-name=${PORTNAME} \
--protocol=${PROTOCOL} \
--session-affinity=None \
--timeout="30s" \
--global"

# list nginx backend specific NEGs
echo "gcloud compute network-endpoint-groups list | grep nginx"

#### NEW GCLB/IAP NEGs
export NEGNAME1=
export NEGZONE1=us-east4-a
export NEGNAME2=
export NEGZONE2=us-east4-b
export NEGNAME3=
export NEGZONE3=us-east4-c

# add NEG to BACKEND
echo "gcloud compute backend-services add-backend ${BACKENDSERVICENAME} \
--project=${PROJECT} \
--network-endpoint-group=${NEGNAME1} \
--network-endpoint-group-zone=${NEGZONE1} \
--balancing-mode=Rate \
--global \
--max-rate-per-endpoint=1000"

echo "gcloud compute backend-services add-backend ${BACKENDSERVICENAME} \
--project=${PROJECT} \
--network-endpoint-group=${NEGNAME2} \
--network-endpoint-group-zone=${NEGZONE2} \
--balancing-mode=Rate \
--global \
--max-rate-per-endpoint=1000"

echo "gcloud compute backend-services add-backend ${BACKENDSERVICENAME} \
--project=${PROJECT} \
--network-endpoint-group=${NEGNAME3} \
--network-endpoint-group-zone=${NEGZONE3} \
--balancing-mode=Rate \
--global \
--max-rate-per-endpoint=1000"
