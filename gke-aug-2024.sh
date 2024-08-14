#1/bin/bash

# set variables
export GCP_PROJECT="initialkubetest"
export GKE_CLUSTER_NAME="cluster-1"
export GKE_VERSION="1.29.6-gke.1038001"
export ZONE="us-central1-c"
export RELEASE_CHANNEL="stable"
export MACHINE_TYPE="e2-micro"
export MAX_PODS="110"
export NUM_NODES="3"
export MIN_NODES="0"
export MAX_NODES="3"
export DISK_SIZE="100"
export VPC_NETWORK="projects/initialkubetest/global/networks/default"
export SUBNET="projects/initialkubetest/regions/us-central1/subnetworks/default"
export IPV4_CIDR="/16"

# source profile
source ~/.bashrc

# set gcp-project
gcloud config set project ${GCP_PROJECT}

gcloud beta container \
--project ${GCP_PROJECT} clusters create ${GKE_CLUSTER_NAME} \
--zone ${ZONE} \
--no-enable-basic-auth \
--cluster-version ${GKE_VERSION} \
--release-channel ${RELEASE_CHANNEL} \
--machine-type ${MACHINE_TYPE} \
--image-type "COS_CONTAINERD" \
--disk-type "pd-balanced" \
--disk-size ${DISK_SIZE} \
--metadata disable-legacy-endpoints=true \
--scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
--max-pods-per-node ${MAX_PODS} \
--num-nodes ${NUM_NODES} \
--logging=SYSTEM,WORKLOAD \
--monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,CADVISOR,KUBELET \
--enable-master-global-access \
--enable-ip-alias \
--network ${VPC_NETWORK} \
--subnetwork ${SUBNET} \
--no-enable-intra-node-visibility \
--default-max-pods-per-node ${MAX_PODS} \
--enable-autoscaling --min-nodes ${MIN_NODES} \
--max-nodes ${MAX_NODES} \
--location-policy "BALANCED" \
--security-posture=standard \
--workload-vulnerability-scanning=standard \
--no-enable-master-authorized-networks \
--addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
--enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-managed-prometheus --enable-shielded-nodes --node-locations "us-central1-c"