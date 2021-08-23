#!/usr/local/bin/bash
PROJECT=ikt
ENV=prod
APP=jenkins
API=/login
DOMAIN_SUFFIX=example.com
ACTION="ping 34.138.69.100"
SCHEDULERJOBNAME=${PROJECT}__${APP}__${ACTION}__${ENV}
SCHEDULE='"*/10 * * * *"'
TARGETTYPE=http
# URI="https://${PROJECT}-iap-${ENV}.${DOMAIN_SUFFIX}/${APP}/${API}"
# URI=https://storage.cloud.google.com/eim-mtech-commonsvc-inv-np-batchupload/invsgherrorreport-df/templates/dev/latest/invsgherrorreport-df-dev
URI=https://storage.cloud.google.com/initialkubetest/jenkins/templates/dev/latest/invsgherrorreport-df-qa
METHOD=GET
echo "gcloud scheduler jobs create ${TARGETTYPE} ${SCHEDULERJOBNAME} \
--schedule ${SCHEDULE} \
--uri ${URI} \
--http-method ${METHOD}"
# gcloud scheduler jobs create ${TARGETTYPE} ${SCHEDULERJOBNAME} --schedule ${SCHEDULE} --uri ${URI} --http-method ${METHOD}
