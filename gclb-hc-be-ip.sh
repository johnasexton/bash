#!/usr/local/bin/bash

# set variables
export GCLBNAME=ikt
export GCPPROJECT=initialkubetest
# calculated variables
export HEALTHCHECKNAME=${GCLBNAME}-hc
export BACKENDSERVICENAME=${GCLBNAME}-be
export IPNAME=${GCLBNAME}-ip

# set project
gcloud config set project ${GCPPROJECT}

# create healthcheck
echo "gcloud compute health-checks create http ${HEALTHCHECKNAME} \
--project=${GCPPROJECT} \
--port=80 \
--request-path=/healthz \
--proxy-header=NONE \
--check-interval=10 \
--timeout=5 \
--unhealthy-threshold=3 \
--healthy-threshold=2"

# create backend service
echo "gcloud compute backend-services create ${BACKENDSERVICENAME} \
--project=${GCPPROJECT} \
--affinity-cookie-ttl=0 \
--connection-draining-timeout=300 \
--no-enable-cdn \
--health-checks=${HEALTHCHECKNAME} \
--iap=disabled \
--port-name=http \
--protocol=HTTP \
--session-affinity=None \
--timeout="30s" \
--global"

# create gclb-static-ip
echo "gcloud compute addresses create ${IPNAME} \
--project=${GCPPROJECT} \
--global"
