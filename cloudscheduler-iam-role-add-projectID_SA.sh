#!/usr/local/bin/bash

export PROJECT=initialkubetest
export PROJECT_NUMBER=`gcloud projects describe ${PROJECT} --format='table(projectNumber)' | egrep [0-9]`
export SA="service-${PROJECT_NUMBER}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"

# echo gcp-project/projectID info to stdout
gcloud config set project ${PROJECT}

echo "SETTING CONTEXT TO:"
echo "GCP-ProjectID = ${PROJECT}"
echo "ProjectID as Integer = ${PROJECT_NUMBER}"

# IAM ROLE GRANT
echo "ADDING IAM ROLE: roles/cloudscheduler.serviceAgent to SA: serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
echo "gcloud projects add-iam-policy-binding ${PROJECT} \
--member serviceAccount:${SA} \
--role roles/cloudscheduler.serviceAgent"

echo "gcloud projects add-iam-policy-binding ${PROJECT} \
--member serviceAccount:${SA} \
--role roles/cloudscheduler.serviceAgent"
