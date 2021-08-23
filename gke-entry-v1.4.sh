#!/bin/bash

# source ~/.bashrc

# usage help
function Usage {
echo "$(basename $0) -c context"
echo " context is required "
echo " format of context is below: "
echo " gke_PROJECT_REGION_CLUSTER "
exit 1
}

# inject args into variables
while getopts "c::" opt; do
  case "$opt" in
    c)  context="${OPTARG}" ;;
    h|*) Usage ;;
  esac
done

# check for missing variables & call usage function if any are null
if [ -z "${context}" ]; then
  Usage
fi

#Check contexts for the added context
if grep ${context} "contexts.txt" ;then
  echo "Context: "${context}" was already present in contexts.txt"
else
  echo ${context} >> contexts.txt
  echo "Context: "${context}" was added to contexts.txt"
fi

#
#!/bin/bash
filename='contexts.txt'
while read line; do
  # reading each line
  loopContext=$line
  #Slice the context into its components
  project="$(cut -d'_' -f2 <<<"${loopContext}")"
  region="$(cut -d'_' -f3 <<<"${loopContext}")"
  cluster="$(cut -d'_' -f4 <<<"${loopContext}")"

  #Echo parsed information
  echo "--------------------------------------------------------------------------------"
  echo "Context: "${loopContext}
  echo "Project: "${project}
  echo "Region: "${region}
  echo "Cluster: "${cluster}
  echo "--------------------------------------------------------------------------------"

  #Get cluster access
  gcloud container clusters get-credentials ${cluster} --region ${region} --project ${project}

  #Switch context
  kubectx ${loopContext}

  #Export env variables for outputfile
  export gke_server_public_ip=`gcloud container clusters describe ${cluster} --project ${project} --region ${region} | grep publicEndpoint | awk '{print $2}'`
  export outputfile=${loopContext}.yaml
  export certificate_authority_data=`gcloud container clusters describe ${cluster} --project ${project} --region ${region} | grep clusterCaCertificate | awk '{print $2}'`
  export namespace=spinnaker
  export spinsecret=`kubectl get secrets -n ${namespace} | grep spinnaker-service-account-token | awk '{print $1}'`
  export user_token=`kubectl get secret/${spinsecret} -n ${namespace} -o yaml | grep token: | awk '{ print $2 }' | base64 --decode `

  # generate outputfile for kubeconfig
  cat << EOF > generated_kubeconfig_entries/${outputfile}
clusters:
  - cluster:
      certificate-authority-data: ${certificate_authority_data}
      server: https://${gke_server_public_ip}
  name: ${loopContext}
contexts:
  - context:
      cluster: ${loopContext}
      user: ${loopContext}-token-user
    name: ${loopContext}
users:
  - name: ${loopContext}-token-user
    user:
      token: ${user_token}
EOF

done < ${filename}
