#!/usr/local/bin/bash 
export GCPPROJECT=initialkubetest
export VPCNETWORK=dataflow-localnet
export DESC="local VPC network for Dataflow jobs"
export SUBNETMODE=auto

gcloud compute \
--project=${GCPPROJECT} networks create ${VPCNETWORK} \
--description=${DESC} \
--subnet-mode=${SUBNETMODE}
--enable-private-ip-google-access
