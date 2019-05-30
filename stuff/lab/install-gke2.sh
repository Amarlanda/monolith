#!/bin/sh
<<<<<<< HEAD
alias k='kubectl'
=======
alias k="kubectl"
sudo usermod -a -G docker ${USER}

>>>>>>> 319713893ce20304f41346c6bf7d3d64ee9bae5b
projectid="trim-keel-212707"
zone="europe-west2-a"
region="europe-west2"
cluster1="cluster01"

PROJECT_ID="$(shell gcloud config list project --format=flattened | awk 'FNR == 1 {print $$2}')"

ZIPKIN_POD_NAME=$(shell kubectl -n istio-system get pod -l app=zipkin -o jsonpath='{.items[0].metadata.name}')
JAEGER_POD_NAME=$(shell kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}')
SERVICEGRAPH_POD_NAME=$(shell kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}')
GRAFANA_POD_NAME=$(shell kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}')
PROMETHEUS_POD_NAME=$(shell kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}')
GCLOUD_USER=$(shell gcloud config get-value core/account)
CONTAINER_NAME="istiotest"
ISTIO_VERSION="1.1.3"



function_sudo () {

  #this does the sudo stuff
  sudo snap install helm
}
function_update_gcloud_acc_var () {

  #gcloud components update

  gcloud config set compute/region $region
  gcloud config set compute/zone $zone
  gcloud config set project $projectid

  #TODO-1 Need to write if statment for building a cluster in GKE {
  # if GKE cliuster existst
  # then connect and install tiller client locall only
  # it no cluster build all from sratch
  #
}
function_Create_cluster () {

  echo "CREATINGGGG: build GKE cluster"

  gcloud container clusters create $cluster1 \
   --num-nodes 2 \
   --machine-type n1-standard-2 \
    --scopes "https://www.googleapis.com/auth/projecthosting,cloud-platform" #TODO:1-gc this the equlivant of IAM

   gcloud container clusters get-credentials \
   $cluster1 --zone $zone --project $projectid

}
function_bind_gcloud_as_Admin () {
  ACCOUNT=$(gcloud info --format='value(config.account)')
  kubectl create clusterrolebinding owner-cluster-admin-binding \
      --clusterrole cluster-admin \
      --user $ACCOUNT
}
function_create_service_account () {
  serviceaccount="api-service-account"
  kubectl create serviceaccount $serviceaccount
  kubectl apply -f /home/amar/linux/lab/api-access-role-bindling.yaml

  secretname1=$(kubectl get serviceaccount api-service-account  -o json | jq -Mr '.secrets[].name')
  token1=$(kubectl get secrets $secretname1 -o json | jq -Mr '.data.token'|base64 --decode)

  ip=$(kubectl get endpoints -o json | jq -Mr '.items[0].subsets[0].addresses[0].ip')
  #ip="35.197.241.83"
  curl -k https://$ip/api/v1/namespaces -H "Authorization: Bearer $token1" --connect-timeout 5 --insecure
}
function_create_service_account_amar () {

  serviceaccount="amar"
  kubectl create serviceaccount $serviceaccount
  #kubectl apply -f /home/amar/linux/lab/api-access-role-bindling.yaml

  secretname1=$(kubectl get serviceaccount api-service-account  -o json | jq -Mr '.secrets[].name')
  token1=$(kubectl get secrets $secretname1 -o json | jq -Mr '.data.token'|base64 --decode)

  ip=$(kubectl get endpoints -o json | jq -Mr '.items[0].subsets[0].addresses[0].ip')
  #ip="35.197.241.83"
  curl -k https://$ip/api/v1/namespaces -H "Authorization: Bearer $token1" --connect-timeout 5 --insecure
}
function_create_service_account_tiller () {
  echo "CREATINGGGG: tiller crap"

  kubectl create serviceaccount --namespace kube-system tiller

  kubectl create -f /home/amar/linux/lab/rbac-config.yaml
}
function_instialise_helm_tiller() {
  helm init --service-account=tiller --wait

  helm repo update # this is the new command
  helm version
  # create serviceaccount --namespace kube-system tiller
  #kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  #kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
}
function_build_jenkins () {
  echo "HELM IS ABOUT TO BUILD Jenkins"
  # Installing Jenkins
#      helm install -n cd stable/jenkins \
#       -f /home/amar/linux/common/_resource/continuous-deployment-on-kubernetes/jenkins/values.yaml \
#       --version 0.16.6 --wait
  tesname="jenkins01"
  #jenkinsyaml="/home/amar/linux/common/_resource/youtube-Continuous Delivery to Kubernetes with Jenkins and Helm/index2018/overrides.yaml"
  jenkinsyaml='/home/amar/linux/common/_resource/youtube-Continuous Delivery to Kubernetes with Jenkins and Helm/index2018/overrides.yaml'

  #testcrumeissue
##  helm install "stable/jenkins" --name $tesname #-f "$jenkinsyaml" "stable/jenkins" --wait
  #helm install --name $tesname -f "$jenkinsyaml" "stable/jenkins" --wait

  #--set Master.HostName=$HOST --wait
  #  --namespace jenkins \

  #helm install stable/jenkins #--values $jenkinsyaml --name cd-jenkins --wait

  service_ip="$(kubectl get service -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}")"
  echo $service_ip
  echo http://$service_ip:8080/login
  echo "Admin Password is:$(kubectl get secret "$tesname" -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)"
  echo "Admin Password is:$(kubectl get secret "$tesname" -o jsonpath="{.data.jenkins-admin-user}" | base64 --decode)"
}
function_backup_cluster_files () {
  #do the report stuff
      helm ls --all jenkins01

      for n in $(kubectl get -o=name pvc,configmap,serviceaccount,ingress,service,deployment,statefulset,hpa,job,cronjob);
       do mkdir -p $(dirname $n);kubectl get -o=yaml --export $n > $n.yaml;
      done
}
function_istio () {
  curl -L https://git.io/getLatestIstio | $ISTIO_VERSION sh -
  cd istio-1.1.3
  export PATH="$PATH:/home/amar/linux/common/_resource_bin_tools/istio-1.1.3/bin"


  curl -L https://git.io/getLatestIstio | sh -
  mv istio-* istio-latest
  export PATH="$PATH:$PWD/istio-latest/bin"
  for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
  #kubectl apply -f katacoda.yaml
  #kubectl apply -f "<(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)"
  #kubectl apply -f install/kubernetes/istio-demo-auth.yaml
}
function_test_to_see_if_jenkins_built () {
    helm ls
    kubectl -n $tesname \
        rollout status deployment jenkins

    open "http://$service_ip:8080/login"
}
function_delete_all (){
  kubectl delete daemonsets,replicasets,services,deployments,pods,rc --all
}
function_pre_req_cert_manager (){
  kubectl apply \
   -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.7/deploy/manifests/00-crds.yaml
   helm repo add jetstack https://charts.jetstack.io
}
function_helm_chart_install (){
  helm upgrade --install cm \
        stable/cert-manager \
        --namespace cert-manager \
        --set ingressShim.defaultIssuerName=letsencrypt-prod \
        --set ingressShim.defaultIssuerKind=ClusterIssuer \
        --set ingressShim.defaultACMEChallengeType=dns01 \
        --set ingressShim.defaultACMEDNS01ChallengeProvider=cloudflare
      }
function_kubernetes_UI () {
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml
}

#function_sudo
function_update_gcloud_acc_var
function_Create_cluster
function_bind_gcloud_as_Admin
function_create_service_account
function_create_service_account_amar
function_create_service_account_tiller
function_instialise_helm_tiller
function_pre_req_cert_manager
function_helm_chart_install
function_build_jenkins
#function_istio
function_backup_cluster_files
function_test_to_see_if_jenkins_built
function_kubernetes_UI

#download-istio:
	wget https://github.com/istio/istio/releases/download/$(ISTIO_VERSION)/istio-$(ISTIO_VERSION)-linux.tar.gz
	tar -zxvf istio-$(ISTIO_VERSION)-linux.tar.gz

#genereate-istio-template:
	helm template istio-$(ISTIO_VERSION)/install/kubernetes/helm/istio --name istio --namespace istio-system --set global.mtls.enabled=true --set tracing.enabled=true --set servicegraph.enabled=true --set grafana.enabled=true > istio.yaml

#deploy-istio:
	kubectl create namespace istio-system
	kubectl apply -f istio.yaml
	kubectl label namespace default istio-injection=enabled --overwrite
	sleep 60
#	kubectl delete pod -n istio-system -l app=prometheus

#  reate-istio-cluster:
  	gcloud beta container --project "$(PROJECT_ID)" clusters create "$(cluster1)" --zone "$(zone)" --machine-type "n1-standard-1" --image-type "COS" --disk-size "100" --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "4" --network "default" --enable-cloud-logging --enable-cloud-monitoring --cluster-version=1.11 --addons HttpLoadBalancing,Istio --istio-config auth=MTLS_STRICT --enable-autoupgrade --enable-autorepair
  	kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(GCLOUD_USER)
  	kubectl label namespace default istio-injection=enabled --overwrite
  	sleep 60
#  	kubectl delete pod -n istio-system -l app=prometheus

#  deploy-stuff:
  	kubectl apply -f ./configs/kube/services.yaml
  	-sed -e 's~<PROJECT_ID>~$(PROJECT_ID)~g' ./configs/kube/deployments.yaml | kubectl apply -f -
#  get-stuff:
  	kubectl get pods && kubectl get svc && kubectl get svc istio-ingressgateway -n istio-system

#  ingress:
  	kubectl apply -f ./configs/istio/ingress.yaml
#  egress:
  	kubectl apply -f ./configs/istio/egress.yaml
#  prod:
  	kubectl apply -f ./configs/istio/destinationrules.yaml
  	kubectl apply -f ./configs/istio/routing-1.yaml
#  retry:
  	kubectl apply -f ./configs/istio/routing-2.yaml
#  canary:
  	kubectl apply -f ./configs/istio/routing-3.yaml


#  start-monitoring-services:
  	@echo "Jaeger: 16686  -  Prometheus: 9090  - Grafana: 3000"
  	$(shell kubectl -n istio-system port-forward $(JAEGER_POD_NAME) 16686:16686 & kubectl -n istio-system port-forward $(SERVICEGRAPH_POD_NAME) 8088:8088 & kubectl -n istio-system port-forward $(GRAFANA_POD_NAME) 3000:3000 & kubectl -n istio-system port-forward $(PROMETHEUS_POD_NAME) 9090:9090)
#  build:
  	docker build -t gcr.io/$(PROJECT_ID)/istiotest:1.0 ./code/code-only-istio
  	docker build -t gcr.io/$(PROJECT_ID)/istio-opencensus-simple:1.0 ./code/code-opencensus-simple
  	docker build -t gcr.io/$(PROJECT_ID)/istio-opencensus-full:1.0 ./code/code-opencensus-full
#  push:
  	gcloud auth configure-docker
  	docker push gcr.io/$(PROJECT_ID)/istiotest:1.0
  	docker push gcr.io/$(PROJECT_ID)/istio-opencensus-simple:1.0
  	docker push gcr.io/$(PROJECT_ID)/istio-opencensus-full:1.0
#  run-local:
#  	docker run -ti --network host gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):1.0
#  restart-demo:
#  	-kubectl delete svc --all
#  	-kubectl delete deployment --all
#  	-kubectl delete VirtualService --all
#  	-kubectl delete DestinationRule --all
#  	-kubectl delete Gateway --all
#  	-kubectl delete ServiceEntry --all
#  uninstall-istio:
#  	-kubectl delete ns istio-system
#  delete-cluster: uninstall-istio
#  	-kubectl delete service frontend
#  	-kubectl delete ingress istio-ingress
#  	gcloud container clusters delete "$(cluster1)" --zone "$(zone)"

  start-opencensus-demo: deploy-stuff ingress egress prod

#  deploy-opencensus-code:
  	kubectl apply -f ./configs/opencensus/config.yaml
  	-sed -e 's~<PROJECT_ID>~$(PROJECT_ID)~g' ./configs/opencensus/deployment.yaml | kubectl apply -f -

#  update-opencensus-deployment:
  	-sed -e 's~<PROJECT_ID>~$(PROJECT_ID)~g' ./configs/opencensus/deployment2.yaml | kubectl apply -f -

#  run-jaeger-local:
#  	docker run -ti --name jaeger -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 --network host jaegertracing/all-in-one:latest

#  run-standalone:
  	kubectl create ns demo
  	kubectl run demo --image=gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):1.0 --namespace demo

#  expose-standalone:
  	kubectl expose deployment demo --target-port=3000 --port=80 --type=LoadBalancer --namespace demo

#  get-standalone:
  	kubectl get deployment --namespace demo
  	kubectl get pods --namespace demo
  	kubectl get svc --namespace demo
