#!/bin/bash
function Usage {
echo "$(basename $0) -p project -r region -c cluster"
echo " project is required "
echo " region is required "
echo " cluster is required."
exit 1
}

while getopts "p:r:c::" opt; do
  case "$opt" in
    p)  project="${OPTARG}" ;;
    r)  region="${OPTARG}" ;;
    c)  cluster="${OPTARG}" ;;
    h|*) Usage ;;
  esac
done

if [ -z "${project}" ]; then
  Usage
elif [ -z "${region}" ]; then
  Usage
elif [ -z "${cluster}" ]; then
  Usage
fi

# spin cmds alias
createpipellc() {
  touch ./"$pipeline".json && sed "s/{{appname}}/$application/g;"  ./"$pipelinefile" > ./"$pipeline".json && spin pipeline save --file ./"$pipeline".json
}

function update_pipeline {
  pipelinefile="$pipeline"-Template.json
  echo "Pipeline "$pipeline" being updated. Updated from template file: $pipelinefile"
  createpipellc
}

function generate_from_template {
  ls -ls
  cp templates/privateTemplate.txt generated_entries/"$context"/private/generatedPrivateTemplate.txt
  sed -i "s,{{endpoint}},$endpoint,g ; s,{{clusterCert}},$clustercert,g ; s,{{context}},$context,g " generated_entries/"$context"/private/generatedPrivateTemplate.txt
}

fetchUserToken() {
  spinnakertokanname=$(kubectl get secrets -n spinnaker | grep spinnaker-service-account-token)
  echo $spinnakertokanname
}

fetchClusterCert() {
  clustercert=$(gcloud container clusters describe $cluster --project $project --region $region | grep clusterCaCertificate)
  echo "ClusterCert: $clustercert"
}

fetchPublicEndpoint() {
  endpoint=$(gcloud container clusters describe $cluster --project $project --region $region | grep publicEndpoint)
  echo "Endpoint: $endpoint"
}

function generate_entries {
  fetchPublicEndpoint
  fetchClusterCert
}

function generate_context {
  context=gke_"$project"_"$region"_"$cluster"
  echo "Context $context based on inputs"
  kubectx $context
}

#Base Script
generate_context && mkdir -p generated_entries/"$context"/private && generate_entries && generate_from_template
