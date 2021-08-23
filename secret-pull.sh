#!/usr/local/bin/bash
export SECRETNAME=ikt-app-sa
export GCPPROJECT=initialkubetest

mkdir -p ~/scripts/creds
gcloud config set project ${GCPPROJECT}
gcloud secrets versions access latest --secret=${SECRETNAME} > ~/scripts/creds/${SECRETNAME}__${GCPPROJECT}.json
echo "created ${SECRETNAME}__${GCPPROJECT}.json"
