#!/usr/local/bin/bash -X

# project viewer for myself at Project scope
export PROJECT=initialkubetest
export ACCOUNT_ID=

# link billing account to gcp-project
gcloud alpha billing projects link ${PROJECT} \
  --billing-account=${ACCOUNT_ID}
