#!/bin/bash -X

# nonprod values
export INITATIVE=ikt
export ENV=prod # "np" or "prod"
export PROJECT=initialkubetest-${ENV}
export FOLDER_ID=
export NAME=${PROJECT}
export ACCOUNT_ID=
export BUSINESSUNIT=ikt
export BUSINESSDOMAIN=sales

echo gcloud projects create ${PROJECT} \
  --no-enable-cloud-apis \
  --folder=${FOLDER_ID} \
  --labels=initiative=${INITATIVE},env=${ENV},bu=${BUSINESSUNIT},domain=${BUSINESSDOMAIN},environment=${ENV} \ # <= reevaluate these LABELS
  --name=${NAME} \
  --billing-project=${ACCOUNT_ID}
