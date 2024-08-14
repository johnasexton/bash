#!/bin/bash

# set variables
export ACCOUNT="john.a.sexton@gmail.com"
export GCP_PROJECT="initialkubetest"
export ZONE="us-central1-c"

gcloud config set account ${ACCOUNT}
gcloud config set project ${GCP_PROJECT}
gcloud config set compute/zone ${ZONE}
gcloud config list
gcloud auth list
