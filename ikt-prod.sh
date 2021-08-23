#!/bin/bash
export USER=john.a.sexton@gmail.com
export GCPPROJECT=initialkubetest
export REGION=us-east1
export ZONE=us-east1-b

gcloud config set account ${USER}
gcloud config set project ${GCPPROJECT}
gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}
gcloud config list
gcloud auth list
