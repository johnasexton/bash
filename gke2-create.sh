#!/usr/local/bin/bash
export GCPPROJECT="initialkubetest"
export GKENAME="ikt-e1-02"
export REGION="us-east1"
export ZONE="us-east1-b"
export GKEVERSION="1.19.12-gke.2100"
export RELEASECHANNEL="stable"
export MACHINETYPE="e2-small"
export DISKTYPE="pd-standard"
export DISKSIZE="25"
export NUMNODES="4"

gcloud beta container \
--project ${GCPPROJECT} clusters create ${GKENAME} \
--zone ${ZONE} \
--no-enable-basic-auth \
--cluster-version ${GKEVERSION} \
--release-channel ${RELEASECHANNEL} \
--machine-type ${MACHINETYPE} \
--image-type "COS_CONTAINERD" \
--disk-type ${DISKTYPE} \
--disk-size ${DISKSIZE} \
--metadata disable-legacy-endpoints=true \
--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
--max-pods-per-node "110" \
--num-nodes ${NUMNODES} \
--logging=SYSTEM,WORKLOAD \
--monitoring=SYSTEM \
--enable-ip-alias \
--network "projects/initialkubetest/global/networks/default" \
--subnetwork "projects/initialkubetest/regions/${REGION}/subnetworks/default" \
--no-enable-intra-node-visibility \
--default-max-pods-per-node "110" \
--no-enable-master-authorized-networks \
--addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
--enable-autoupgrade \
--enable-autorepair \
--max-surge-upgrade 1 \
--max-unavailable-upgrade 0 \
--enable-shielded-nodes \
--node-locations ${ZONE}
