
apt-get update && apt-get upgrade
apt-get install vim
apt-get install dnsutils -y
nslookup default.svc.cluster.local
nslookup 10.59.240.10

cat /etc/hostname
cat etc/resolv.conf

#
k get service --namespace=kube-system
k exec -it kube-dns -- /bin/bash
kube-dns.kube-system.svc.cluster.local


# create a load balancer service
kubectl run hello-world --replicas=2 --labels="run=load-balancer-example" \
--image=gcr.io/google-samples/node-hello:1.0  --port=8080

kubectl get deployments jenkins01
kubectl describe deployments hello-worldkubectl get replicasets
kubectl describe replicasetskubectl get replicasets
kubectl describe replicasets
kubectl expose deployment hello-world --type=NodePort --name=example-service
kubectl describe services example-service
