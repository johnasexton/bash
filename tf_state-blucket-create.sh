#!/usr/local/bin/bash
export GCPPROJECT=initialkubetest
gcloud config set project ${GCPPROJECT}
echo "gsutil mb gs://tf-state-${GCPPROJECT}"
