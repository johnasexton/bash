#!/usr/local/bin/bash

# user set variables
export GCPPROJECTID="initialkubetest"
export REGION="us-central1"
export TYPE="serviceAccount" # must be: "group","user","serviceAccount"
export ROLE="roles/cloudscheduler.serviceAgent"
# calculated variables
export GCPPROJINT=`gcloud projects describe ${GCPPROJECTID} --format='table(projectNumber)' | grep -v PROJECT_NUMBER`
export ID="service-${GCPPROJINT}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"

# set project scope
gcloud config set project ${GCPPROJECTID}

# enable API
gcloud services enable cloudscheduler.googleapis.com

# Create default AppEngine application
gcloud app create --region=${REGION}
gcloud app describe

# show IAM role grants as echo "" only
echo "gcloud projects add-iam-policy-binding ${GCPPROJECTID} \
  --member ${TYPE}:${ID} \
  --role ${ROLE}"
