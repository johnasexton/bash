#!/bin/bash
export project_id=initialkubetest
export region=us-east1
export cluster_name=ikt-e1-01
export gke_server_public_ip=35.0.0.0
export outputfile=${cluster_name}.txt
export user_token=
export certificate_authority_data=

cat << EOF > ${outputfile}
clusters: # add entry to clusters
- cluster:
    certificate-authority-data: ${certificate_authority_data}
    server: https://${gke_server_public_ip}
  name: gke_${project_id}_${region}_${cluster_name}

contexts: # add entry to contexts
 - context:
     cluster: gke_${project_id}_${region}_${cluster_name}
     user: gke_${project_id}_${region}_${cluster_name}-token-user
   name: gke_${project_id}_${region}_${cluster_name}

users: # add entry to users
  - name: gke_${project_id}_${region}_${cluster_name}-token-user
    user:
      token: ${user_token}
      EOF
