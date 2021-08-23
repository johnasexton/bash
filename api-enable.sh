#!/usr/local/bin/bash
PROJECT_NAME=initialkubetest
API=bigquerydatatransfer.googleapis.com
API_DESCRIPTION="BigQuery Data Transfer API"

### Enable a new GCP API
echo "enabling ${API_DESCRIPTION}"
echo "executing: gcloud services enable ${API} --project=${PROJECT_NAME}"

### Enable API
gcloud services enable ${API} \
--project=${PROJECT_NAME}
