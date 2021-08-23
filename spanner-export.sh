#!/usr/local/bin/bash

# set variables
export GCPPROJ="initialkubetest"
export SPANNERINST="cs-ikt-inst"
export SPANNERDB="cs-ikt-prod-db"
export VPCNETWORK="isonet-ikt-datalab-perf"
export VPCSUBNET="isonet-ikt-datalab-perf-e4"
export DFREGION="us-east1"
export DFBUCKET="initialkubetest_prod_spanner_bkp"
export DFSA="dataflow-worker@<project>"
export DFTEMPLATE="gs://dataflow-templates/latest/Cloud_Spanner_to_GCS_Avro"
export DFMAXWORKERS=2
# calculated variables
export DFDATE=`date '+%Y%m%d%s'`
export DFSTGLOC="gs://${DFBUCKET}/tmp/"
export DFOUTDIR="gs://${DFBUCKET}/exports/${SPANNERDB}_export_${DFDATE}"
export DFPARAMS="instanceId=${SPANNERINST},databaseId=${SPANNERDB},outputDir=${DFOUTDIR}"
export DFNAME="scm-sre-${SPANNERINST}-export"
export DFSUBNET="regions/${DFREGION}/subnetworks/${VPCSUBNET}"

# Spanner Export via AVRO Dataflow template
echo "gcloud beta dataflow jobs run ${DFNAME} \
--gcs-location=${DFTEMPLATE} \
--parameters=${DFPARAMS} \
--max-workers=${DFMAXWORKERS} \
--network=${VPCNETWORK} \
--region=${DFREGION} \
--subnetwork=${DFSUBNET} \
--staging-location=${DFSTGLOC} \
--service-account-email=${DFSA} \
--disable-public-ips"
