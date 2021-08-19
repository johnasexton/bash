#!/usr/local/bin/bash
export GCPPROJECT="initialkubetest"
export GKENAME="autopilot-cluster-ikt-e1-01"
export REGION="us-east1"
export ZONE="us-east1-b"
export GKEVERSION="1.19.12-gke.2100"
export RELEASECHANNEL="stable"
export MACHINETYPE="e2-standard"
export DISKTYPE="pd-standard"
export DISKSIZE="25"
export MAXPODSPERNODE="110"
export NUMNODES="3"

gcloud beta container \
--project ${GCPPROJECT} clusters create-auto ${GKENAME} \
--region ${REGION} \
--release-channel ${RELEASECHANNEL} \
--network "projects/initialkubetest/global/networks/default" \
--subnetwork "projects/initialkubetest/regions/${REGION}/subnetworks/default" \
--cluster-ipv4-cidr "/17" \
--services-ipv4-cidr "/22"
