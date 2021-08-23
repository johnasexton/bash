#!/usr/local/bin/bash

# SET VARIABLES
# gcp-project
export GCPPROJNAME=initialkubetest
# VPC Network
export VPCNAME=peered-ikt-prod
export VPCDESC="ikt-peered-vpc"
export SUBNETMODE=custom
export BGPROUTINGMODE=regional
# VPC SUBNET1
export SUBNET1=peered-ikt-prod-e1
export SUBNET1REGION=us-east1
export SUBNET1CIDR=10.0.0.0/23
# VPC SUBNET2
export SUBNET2=peered-ikt-prod-e4
export SUBNET2REGION=us-east4
export SUBNET2CIDR=10.1.0.0/23

# set project
echo "gcloud config set project ${GCPPROJNAME}"

# create VPC Network
echo "gcloud compute networks create ${VPCNAME} \
--project=${GCPPROJNAME} \
--description=${VPCDESC} \
--subnet-mode=${SUBNETMODE} \
--bgp-routing-mode=${BGPROUTINGMODE} \
--enable-private-ip-google-access"

# create VPC SUBNET1
echo "gcloud compute networks subnets create ${SUBNET1} \
--project=${GCPPROJNAME} \
--range=${SUBNET1CIDR} \
--network=${VPCNAME} \
--region=${SUBNET1REGION}"

# create VPC SUBNET1
echo "gcloud compute networks subnets create ${SUBNET2} \
--project=${GCPPROJNAME} \
--range=${SUBNET2CIDR} \
--network=${VPCNAME} \
--region=${SUBNET2REGION}"
