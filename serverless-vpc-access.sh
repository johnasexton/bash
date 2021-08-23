#!/usr/local/bin/bash

# user defined variables
export GCPPROJECTID="initialkubetest"
export REGION="us-east1"
export VPCNETWORK="initialkubetest-internal"
export CUSTOMIPRANGE="10.252.0.0/28"
export CONNECTOR_NAME=${VPCNETWORK}
export MINREPLICAS=2
export MAXREPLICAS=10
export MACHINETYPE=e2-micro
# calculated variables
export TYPE="serviceAccount" # must be: "group","user","serviceAccount"
export ROLE="roles/cloudscheduler.serviceAgent"
export GCPPROJINT=`gcloud projects describe ${GCPPROJECTID} --format='table(projectNumber)' | grep -v PROJECT_NUMBER`
export ID="service-${GCPPROJINT}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"

# set project scope
gcloud config set project ${GCPPROJECTID}

# enable API for serverless vpc connnector:
echo "gcloud services enable vpcaccess.googleapis.com"

# create Serverless VPC Connector
echo "gcloud compute networks vpc-access connectors create ${CONNECTOR_NAME} \
--region=${REGION} \
--network=${VPCNETWORK} \
--range=${CUSTOMIPRANGE} \
--min-instances=${MINREPLICAS} \
--max-instances=${MAXREPLICAS} \
--machine-type=${MACHINETYPE}"

# IAM role grants
echo "gcloud projects add-iam-policy-binding ${GCPPROJECTID} \
--member ${TYPE}:${ID} \
--role ${ROLE}"
