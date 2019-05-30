#!/bin/sh
projectid="trim-keel-212707"
zone="europe-west2-a"
region="europe-west2"
cluster1="spikey-dev-cluster"
cluster2="jenkins-cd"

#gcloud components update

gcloud config set compute/region $region
gcloud config set compute/zone $zone

gcloud container clusters create $cluster2 \
 --num-nodes 2 \
 --machine-type n1-standard-2 \ #TODO:1-gc this the equlivant of IAM
  --scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform"

 gcloud container clusters get-credentials \
 $cluster2 --zone $zone --project $projectid

#installs sample-app
cd /home/amar/linux/continuous-deployment-on-kubernetes/sample-app/k8s/production
kubectl apply -f ../../k8s/production/ -n production
