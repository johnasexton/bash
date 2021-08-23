#!/bin/bash
gcloud config set account redvoid@gmail.com
gcloud config set project nginx-k8s-211319
gcloud config set compute/zone us-central1-a
gcloud config list
gcloud auth list
