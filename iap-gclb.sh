#!/usr/local/bin/bash

# VARIABLES
export PROJECT=initialkubetest
export CNAME=ikt
export DOMAIN=example.com
export IP=35.0.0.0
export NAMESPACE=monitoring
export GCLBNAME=gclb-${CNAME}
export FQDN=${CNAME}.${DOMAIN}
export HEALTHCHECKNAME=${GCLBNAME}-hc
export FRONTENDSERVICENAME=${GCLBNAME}-fe
export BACKENDSERVICENAME=${GCLBNAME}-be
export PORTNAME=HTTP
export PROTOCOL=http
export PORTNUMBER=80
export NEGZONE=us-east1-a

# create namespace
# echo "kubectl create ns ${NAMESPACE}"

# create tls resources
# echo "kubectl apply -f ~/workspace/eim/manifests/rbac/tls-cert-devops-fds-com.yaml"

# gclb nginx ingress controller
# echo "bash ~/workspace/scm/helm/nginx-ingress-gclb/install.sh"

# bash install.sh (for troubleshooting errors, apply install.sh lines one by one
#!/bin/bash
# kubectl apply -f ./backendconfig.yaml
# kubectl apply -f ./ingress-healthcheck.yaml
# kubectl apply -f ./ingress-gclb.yaml
# kubectl apply -f ./backendconfig-ca-corp-internal.yaml
# helm install --name nginx-ingress-gclb-sr --namespace nginx-ingress-gclb-sr -f ./values.yaml /Users/b004829/workspace/github/charts/stable/nginx-ingress

# health check
gcloud compute health-checks create ${portname} ${healthcheckname} --project=${project} --port=${portnumber} --request-path=/healthz --proxy-header=NONE --check-interval=10 --timeout=5 --unhealthy-threshold=3 --healthy-threshold=2

# backend service
# ABSTRACT: gcloud compute backend-services create ${backendname} --project=${project} --affinity-cookie-ttl=0 --connection-draining-timeout=300 --no-enable-cdn --health-checks=${healthcheckname} --iap=disabled --port-name=${port} --protocol=${protocol} --session-affinity=None --timeout="30s" --global
# EXAMPLE: gcloud compute backend-services create gclb-eim-dev-be --project=mtech-commonsvc-inv-np --affinity-cookie-ttl=0 --connection-draining-timeout=300 --no-enable-cdn --health-checks=gclb-eim-dev-hc --iap=disabled --port-name=http --protocol=HTTP --session-affinity=None --timeout="30s" --global
gcloud compute backend-services create ${backendname} --project=${project} --affinity-cookie-ttl=0 --connection-draining-timeout=300 --no-enable-cdn --health-checks=${healthcheckname} --iap=disabled --port-name=${port} --protocol=${protocol} --session-affinity=None --timeout="30s" --global

# NEGs
# ABSTRACT:
# EXAMPLE: gcloud compute backend-services add-backendgclb-eim-dev-be--project=mtech-commonsvc-inv-np --network-endpoint-group=gclb-eim-dev-neg--network-endpoint-group-zone=us-east4-a --balancing-mode=Rate --global --max-rate-per-endpoint=1000
gcloud compute backend-services add-backend gclb-eim-dev-be--project=mtech-commonsvc-inv-np --network-endpoint-group=gclb-eim-dev-neg--network-endpoint-group-zone=us-east4-a --balancing-mode=Rate --global --max-rate-per-endpoint=1000

# abstract
echo "gcloud compute network-endpoint-groups list"

# static ip
# ABSTRACT: gcloud compute addresses create ${IPNAME} --project=${PROJECT} --global
# EXAMPLE: gcloud compute addresses create gclb-eim-dev-ip --project=mtech-commonsvc-inv-np --global

# blowout and redo
# drop GCLB load balancer and cascade all
# kubectl delete namespace/${NAMESPACE}
# kubectl delete namespace/ingress-nginx
# kubectl delete namespace/nginx-ingress-gclb-sr
# kubectl delete namespace/nginx-ingress-gclb
