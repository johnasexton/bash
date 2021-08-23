#!/usr/local/bin/bash

# project viewer for SCM-SRE Team human AD Group at Project scope
export PROJECT="initialkubetest"
export TYPE="serviceAccount" # must be: "group","user","serviceAccount"
export ID="service-${PROJECT_INTEGER}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
export ROLE="roles/cloudscheduler.serviceAgent"

# echo "...executing gcloud projects add-iam-policy-binding ${PROJECT} --member ${TYPE}:${ID} --role ${ROLE}"
echo gcloud projects add-iam-policy-binding ${PROJECT} \
  --member ${TYPE}:${ID} \
  --role ${ROLE}
