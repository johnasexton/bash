#!/bin/bash
export podname=${1}
export lport=8888
export rport=8080
export namespace=dev
kubectl port-forward ${podname} ${lport}:${rport} -n ${namespace}
