#!/bin/sh

sudo snap install helm

projectid="trim-keel-212707"
zone="europe-west2-a"
region="europe-west2"
cluster1="spikey-dev-cluster"
cluster2="cluster"
serviceaccount="api-service-account"

#gcloud components update

gcloud config set compute/region $region
gcloud config set compute/zone $zone
gcloud config set project $projectid

#TODO-1 Need to write if statment for building a cluster in GKE {
# if GKE cliuster existst
# then connect and install tiller client locall only
# it no cluster build all from sratch
#

echo "CREATINGGGG: build GKE cluster"

gcloud container clusters create $cluster2 \
 --num-nodes 2 \
 --machine-type n1-standard-2 \
  --scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform" #TODO:1-gc this the equlivant of IAM

 gcloud container clusters get-credentials \
 $cluster2 --zone $zone --project $projectid

#downloads helm
 #/home/amar/linux/common/_resource/continuous-deployment-on-kubernetes/sample-app/k8s/production
#cp /home/amar/linux/common/_resource/helm/linux-amd64 /home/amar/linux/common/_resource_bin_tools
#installs sample-app

ACCOUNT=$(gcloud info --format='value(config.account)')
kubectl create clusterrolebinding owner-cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $ACCOUNT

echo "CREATINGGGG: service account"

serviceaccount="api-service-account"
#kubectl create serviceaccount $serviceaccount
kubectl apply -f /home/amar/linux/lab/api-access-role-bindling.yaml

secretname1=$(kubectl get serviceaccount api-service-account  -o json | jq -Mr '.secrets[].name')
token1=$(kubectl get secrets $secretname1 -o json | jq -Mr '.data.token'|base64 --decode)

ip=$(kubectl get endpoints -o json | jq -Mr '.items[0].subsets[0].addresses[0].ip')
#ip="35.197.241.83"
curl -k https://$ip/api/v1/namespaces -H "Authorization: Bearer $token1" --connect-timeout 5 --insecure


echo "CREATINGGGG: tiller crap"

kubectl create serviceaccount --namespace kube-system tiller

kubectl create -f /home/amar/linux/lab/rbac-config.yaml

helm init --service-account=tiller --wait

# create serviceaccount --namespace kube-system tiller
#kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
#kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

  helm repo update # this is the new command
  helm version

      # Installing Jenkins
#      helm install -n cd stable/jenkins \
#       -f /home/amar/linux/common/_resource/continuous-deployment-on-kubernetes/jenkins/values.yaml \
#       --version 0.16.6 --wait

#run - check you have got the right cluster
#copy helm to relivant place
# cp helm /home/amar/linux/common/_resource/continuous-deployment-on-kubernetes

#kubectl apply -f ../../k8s/production/ -n production
# ls

    #TODO: HELMS FROM YOUTUBE VIDEO

          ##using helms form youtube video
          #helm install --name cd -f overrides.yaml stable/jenkins

    echo "HELM IS ABOUT TO BUILD Jenkins"
    tesname="jenkins01"
    #jenkinsyaml="/home/amar/linux/common/_resource/youtube-Continuous Delivery to Kubernetes with Jenkins and Helm/index2018/overrides.yaml"
    jenkinsyaml='/home/amar/linux/common/_resource/youtube-Continuous Delivery to Kubernetes with Jenkins and Helm/index2018/overrides.yaml'

    helm install --name $tesname -f "$jenkinsyaml" "stable/jenkins" --wait
    #helm install stable/jenkins --name $tesname -f $jenkinsyaml

    #--set Master.HostName=$HOST --wait
    #  --namespace jenkins \

    #helm install stable/jenkins #--values $jenkinsyaml --name cd-jenkins --wait

    service_ip="$(kubectl get service -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")"
    echo $service_ip
    echo http://$service_ip:8080/login
    echo "Admin Password is:$(kubectl get secret "$tesname" -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)"

### use this for the if statment
#helm ls --all jenkins01

    kubectl -n $tesname \
        rollout status deployment jenkins

    open "http://$service_ip:8080/login"

#do the report stuff

    for n in $(
    kubectl get -o=name pvc,configmap,serviceaccount,ingress,service,deployment,statefulset,hpa,job,cronjob);
     do mkdir -p $(dirname $n);kubectl get -o=yaml --export $n > $n.yaml;
    done

#downloads the lastest istio binary
curl -L https://git.io/getLatestIstio

curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.3 sh -
cd istio-1.1.3
export PATH="$PATH:/home/amar/linux/common/_resource_bin_tools/istio-1.1.3/bin"


$ curl -L https://git.io/getLatestIstio | sh -
$ mv istio-* istio-latest
$ export PATH="$PATH:$PWD/istio-latest/bin"
for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
kubectl apply -f katacoda.yaml
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl apply -f install/kubernetes/istio-demo-auth.yaml

#    helm install install/kubernetes/helm/istio-init --name istio-init --namespace istio-system
#    helm install install/kubernetes/helm/istio --name istio --namespace istio-system
