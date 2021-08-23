#!/usr/local/bin/bash

# user input required set variables
export NS=prod
export GKENAME=ikt-e1-01
export GKECLUSTER=gke_initialkubetest_us-east1-b_ikt-e1-01
export GCPPROJECT=initialkubetest

# calculated variables - no user entry required
export GCSBUCKET=manifest-backup-${GCPPROJECT}
export BACKUPDATE=`date +%Y-%m-%d-%H%M%S`
export OUTPUTDIR=${GKENAME}_${BACKUPDATE}
export MYARRAY=`kubectl get deployments -n ${NS} | awk '{print $1}' | grep -v NAME`

# declare an array of gke microservices
declare -a arr=(${MYARRAY})

# set project & cluster
echo "gcloud config set project ${GCPPROJECT}"
gcloud config set project ${GCPPROJECT}
echo "kubectx ${GKECLUSTER}"
kubectx ${GKECLUSTER}

# make output directory
mkdir ./${OUTPUTDIR}

# list array
echo "Preparing to generate manifests from ${GKENAME} for applications:"
for i in "${arr[@]}"
do
	echo $i
done

# now loop through the above array to generate k8s manifests to output directory
for i in "${arr[@]}"
do
   echo "Generating $i manifests"
   kubectl get deployment/$i -n ${NS} -o yaml > ./${OUTPUTDIR}/$i-deployment-${NS}.yaml
   kubectl get service/$i -n ${NS} -o yaml > ./${OUTPUTDIR}/$i-service-${NS}.yaml
   kubectl get ingress/$i -n ${NS} -o yaml > ./${OUTPUTDIR}/$i-ingress-${NS}.yaml
   kubectl get hpa/$i -n ${NS} -o yaml > ./${OUTPUTDIR}/$i-hpa-${NS}.yaml
	 kubectl get servicemonitor/$i -n monitoring -o yaml > ./${OUTPUTDIR}/$i-servicemonitor-${NS}.yaml
done

# write output directory to GCS BUCKET
gsutil -m cp -r ./${OUTPUTDIR} gs://${GCSBUCKET}

# cleanup temp output directory
rm -rf ./${OUTPUTDIR}
