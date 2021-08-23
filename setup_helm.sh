#!/usr/local/bin/bash

# presumes helm version 2.x - 3.x does not require tiller
setup_helm() {
 kubectx $1
 kubectl --namespace kube-system create sa tiller
 # create a cluster role binding for tiller
 kubectl create clusterrolebinding tiller \
   --clusterrole cluster-admin \
   --serviceaccount=kube-system:tiller
 echo "initialize helm"
 # initialized helm within the tiller service account
 helm init --service-account tiller
}

setup_helm
