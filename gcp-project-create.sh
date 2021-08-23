#!/bin/bash -X

# nonprod values
export INITATIVE=ikt
export ENV=prod # "np" or "prod"
export PROJECT=initialkubetest-${ENV}
export FOLDER_ID=
export NAME=${PROJECT}
export ACCOUNT_ID=

echo gcloud projects create ${PROJECT} \
  --no-enable-cloud-apis \
  --folder=${FOLDER_ID} \
  --labels=initiative=${INITATIVE},env=${ENV},bu=wms,domain=supply-chain,environment=${ENV} \ # <= reevaluate these LABELS
  --name=${NAME} \
  --billing-project=${ACCOUNT_ID}
