#help find pods
kubectl get pods -o wide

#get pod name
kubectl get pods --no-headers -o custom-columns=":metadata.name"
  #just get the name
  SOURCE_POD=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})


#conenct to pod dynamicallu by name
kubectl exec -it $(kubectl get pods --no-headers -o custom-columns=":metadata.name") -- /bin/bash
kubectl exec -itkube
#check logs for jenkins server
kubectl logs $(kubectl get pods --no-headers -o custom-columns=":metadata.name")

#lookup json
kubectl get service -o json | jid -q | pbcopy

#get admin cert
serviceaccount="api-service-account"
kubectl create serviceaccount $serviceaccount
kubectl apply -f /home/amar/linux/lab/api-access-role-bindling.yaml

secretname1=$(kubectl get serviceaccount api-service-account  -o json | jq -Mr '.secrets[].name')
token1=$(kubectl get secrets $secretname1 -o json | jq -Mr '.data.token'|base64 --decode)

#token1=$(kubectl get secrets $secretname1 -o json | jid | copgq -Mr '.data.token'|base64 --decode)

#ip=$(kubectl get endpoints -o json | jq -Mr '.items[2].subsets[0].addresses[0].ip')
ip="35.197.241.83"
curl -k https://$ip/api/v1/namespaces -H "Authorization: Bearer $token1" --insecure


secretname1=$(kubectl get serviceaccount default  -o json | jq -Mr '.secrets[].name')
token1=$(kubectl get secrets $secretname1 -o json | jq -Mr '.data.token'|base64 --decode)

ip=$(kubectl get endpoints -o json | jq -Mr '.items[0].subsets[0].addresses[0].ip')
curl https://$ip/api/v1/namespaces -H "Authorization: Bearer $token1" --insecure

kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --serviceaccount=api-service-account

kubectl get secrets -o yaml >> test/allscecretsyaml.yaml

kubectl apply -f /home/amar/linux/common/_resource/nigelpoulton-acloudguru-k8-deep-dive/Kubernetes_Deep_Dive_NP/lesson-rbac/new-role.yml

##get-app-versions-tiller
kubectl get configmap -n kube-system
