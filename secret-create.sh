#!/usr/local/bin/bash

export SECRETNAME=iap-app-sa
export NAMESPACE=prod
export FULLPATH=/Users/johnasexton/Downloads
export FILENAME=<something>.json


echo "kubectl create secret generic ${SECRETNAME}  \
--from-file=key.json=${FULLPATH}/${FILENAME} \
-n ${NAMESPACE}"
