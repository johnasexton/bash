#!/usr/local/bin/bash
export GCPPROJECT="initialkubetest"
export CLOUDFUNCTION="ikt-import"
export REGION="us-east1"
export SPANNERDATABASE="ikt-db"
export ENV="prod"

gcloud functions call ${CLOUDFUNCTION} \
--project=${GCPPROJECT} \
--region=${REGION} \
--data='{"databaseId":"ikt-db", "env":"prod", "projectId":"initialkubetest", "region":"us-east1"}'
