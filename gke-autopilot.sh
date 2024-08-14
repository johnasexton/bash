#!/bin/bash

# set variables
export GCP_PROJECT="initialkubetest"
export GKE_CLUSTER_NAME="autopilot-cluster-1"
export REGION="us-central1"
export RELEASE_CHANNEL="regular"
export VPC_NETWORK=""
export SUBNET=""
export IPV4_CIDR="/16"

# source profile
source ~/.bashrc

# set gcp-project
gcloud config set project ${GCP_PROJECT}

# create gke autopilot cluster
gcloud beta container \
--project ${GCP_PROJECT} clusters create-auto ${GKE_CLUSTER_NAME} \
--region ${REGION} \
--release-channel ${RELEASE_CHANNEL} \
--network ${VPC_NETWORK} \
--subnetwork ${SUBNET} \
--cluster-ipv4-cidr ${IPV4_CIDR} \
--binauthz-evaluation-mode=DISABLED