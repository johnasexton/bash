#!/bin/bash
export UID=johnasexton
export KEYLOC=/Users/${UID}/workspace/<file>.json
export SA=scm-terraform@<gcpproject>.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=${KEYLOC}
set account: gcloud config set account ${SA}
gcloud auth activate-service-account ${SA} --key-file=${KEYLOC}
gcloud config list
gcloud auth list
