#!/usr/local/bin/bash
export UID=john.a.sexton@gmail.com
export APPLICATION=ikt
export NAMESPACE=prod
export REPO=<git-repositoryname>
export WORKSPACE=/Users/${UID}/workspace/johnasexton/${REPO}
export MANIFESTLOCALE=/Users/${UID}/workspace/johnasexton/${REPO}
# export PROPERTIESLOCALE=service/src/main/resources/application.properties # java/spring apps standard locale
export PROPERTIESLOCALE=src/server/env/application.properties # reactJS/nodeJS apps standard locale

# delete configmap
echo "deleting configmap/${APPLICATION}-config -n ${NAMESPACE}"
kubectl delete configmap/${APPLICATION}-config -n ${NAMESPACE}

# delete deployment
echo "deleting deployment/${APPLICATION} -n ${NAMESPACE}"
# kubectl delete deployment/${APPLICATION} -n ${NAMESPACE}

# get latest configmap from gitlab scm on origin master
# repo must already be cloned to local for this to work
echo "git pull origin master on ${APPLICATION}"
cd ${WORKSPACE}/${APPLICATION}
git stash
git checkout master
git pull origin

# create configmap
echo "creating configmap ${APPLICATION}-config from file ${WORKSPACE}/${APPLICATION}/${PROPERTIESLOCALE} -n ${NAMESPACE}"
kubectl create configmap ${APPLICATION}-config --from-file=${WORKSPACE}/${APPLICATION}/${PROPERTIESLOCALE} -n ${NAMESPACE}

# deploy application
echo "deploying ${APPLICATION}-deployment-${NAMESPACE}.yaml"
kubectl apply -f ${MANIFESTLOCALE}/${APPLICATION}-deployment-${NAMESPACE}.yaml

# exit
echo "Completed"
kubectl get deployment/${APPLICATION} -n ${NAMESPACE} -o yaml
kubectl get configmap/${APPLICATION}-config -n ${NAMESPACE} -o yaml
