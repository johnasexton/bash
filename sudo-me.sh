#!/bin/bash
export UID=johnasexton
export USERID=john.a.sexton@gmail.com
# export GOOGLE_APPLICATION_CREDENTIALS=${KEYLOC}
gcloud config set account ${USERID}
gcloud auth activate-service-account ${USERID}
# gcloud auth activate-service-account ${SA} --key-file=${KEYLOC}
gcloud config list
gcloud auth list
