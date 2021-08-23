#!/usr/local/bin/bash
PROJECT=ikt
ENV=prod
APP=jenkins
API=actuator/health
DOMAIN_SUFFIX=example.com
ACTION=trigger
SCHEDULERJOBNAME=${PROJECT}__${APP}__${ACTION}__${ENV}
SCHEDULE='"*/10 * * * *"'
TARGETTYPE=http

URI="https://${PROJECT}-iap-${ENV}.${DOMAIN_SUFFIX}/${APP}/${API}"
METHOD=GET

echo "gcloud scheduler jobs create ${TARGETTYPE} ${SCHEDULERJOBNAME} --schedule ${SCHEDULE} --uri ${URI} --http-method ${METHOD}"
# gcloud scheduler jobs create ${TARGETTYPE} ${SCHEDULERJOBNAME} --schedule ${SCHEDULE} --uri ${URI} --http-method ${METHOD}
