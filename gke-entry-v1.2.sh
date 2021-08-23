#!/bin/bash

# source ~/.bashrc

# usage help
function Usage {
echo "$(basename $0) -p project -r region -c cluster"
echo " project is required "
echo " region is required "
echo " cluster is required."
exit 1
}

# inject args into variables
while getopts "p:r:c::" opt; do
  case "$opt" in
    p)  project="${OPTARG}" ;;
    r)  region="${OPTARG}" ;;
    c)  cluster="${OPTARG}" ;;
    h|*) Usage ;;
  esac
done

# check for missing variables & call usage function if any are null
if [ -z "${project}" ]; then
  Usage
elif [ -z "${region}" ]; then
  Usage
elif [ -z "${cluster}" ]; then
  Usage
fi

# set kubectx context
kubectx gke_${project}_${region}_${cluster}

# export env variables for outputfile
export gke_server_public_ip=`gcloud container clusters describe ${cluster} --project ${project} --region ${region} | grep publicEndpoint | awk '{print $2}'`
export outputfile=${cluster}.txt
export certificate_authority_data=`gcloud container clusters describe ${cluster} --project ${project} --region ${region} | grep clusterCaCertificate | awk '{print $2}'`
export namespace=spinnaker
export spinsecret=`kubectl get secrets -n ${namespace} | grep spinnaker-service-account-token | awk '{print $1}'`
export user_token=`kubectl get secret/${spinsecret} -n ${namespace} -o yaml | grep token: | awk '{ print $2 }' | base64 --decode | sed -e 's/$/\n/'`

# generate outputfile
cat << EOF > ${outputfile}
clusters: # add entry to clusters
- cluster:
    certificate-authority-data: ${certificate_authority_data}
    server: https://${gke_server_public_ip}
  name: gke_${project}_${region}_${cluster}

contexts: # add entry to contexts
 - context:
     cluster: gke_${project}_${region}_${cluster}
     user: gke_${project}_${region}_${cluster}-token-user
   name: gke_${project}_${region}_${cluster}

users: # add entry to users
  - name: gke_${project}_${region}_${cluster}-token-user
    user:
      token: ${user_token}
EOF
