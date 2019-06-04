```##### Gateway

tony@airwolf:~$ k get gw  my-gateway -o yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  annotations:
  name: my-gateway
  namespace: default
spec:
  selector:
    istio: ingressgateway
  servers:
  - hosts:
    - '*'
    port:
      name: http
      number: 80
      protocol: HTTP


k get virtualservice frontend -o yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"networking.istio.io/v1alpha3","kind":"VirtualService","metadata":{"annotations":{},"name":"frontend","namespace":"default"},"spec":{"gateways":["my-gateway"],"hosts":["*"],"http":[{"route":[{"destination":{"host":"frontend","port":{"number":80}}}]}]}}
  creationTimestamp: "2019-05-30T10:39:46Z"
  generation: 1
  name: frontend
  namespace: default
  resourceVersion: "1354576"
  selfLink: /apis/networking.istio.io/v1alpha3/namespaces/default/virtualservices/frontend
  uid: 3dffb7ad-82c7-11e9-9504-02e21c4418a0
spec:
  gateways:
  - my-gateway
  hosts:
  - '*'
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: frontend
        port:
          number: 3000




697  kx atlas --all-namespaces
  698  k get pods --all-namespaces
  699  kubens istio-system
  700  k get svc
  701  k get pods
  702  k get pods -o yaml
  703  k get pods -o wide
  704  k get service -o wide
  705  k get pods --all-namespaces
  706  k describe pod aisp-deployment-58f56857bf-whwkf -n coop-dev
  707  kubens coop-dev
  708  k get svc
  709  k get virtualservice
  710  k get gateway
  711  k get gateway --all-namespaces
  712  k get gateway my-gateway
  713  k get gateway my-gateway -o yaml
  714  k get pod
  715  k get virtualservice frontend
  716  k get virtualservice frontend -o yaml
  717  k get pod
  718  k get pod --all-namespaces
  721  k get pod --all-namespaces
  722  k get virtualservice frontend -o yaml
  723  k get virtualservice --all-namespaces
  724  kubens default
  725  k get svc
  726  k get virtualservce
  727  k get virtualservice
  728  k get gw
  729  k get gw my-gateway -o yaml
  730  ls
  731  cd
  732  ls
  733  k get virtualservice
  734  k get virtualservice frontend -o yaml
  735  k edit virtualservice frontend -o yaml
  736  k edit virtualservice frontend -o yaml
  737  k get virtualservice frontend -o yaml --help
  738  k get virtualservice frontend -f foo
  739  k get virtualservice frontent -o yaml
  740  k get virtualservice frontend -o yaml  >frontend.yaml
  741  vi frontend.yaml
  742  k get virtualservice frontend -o yaml
  743  k get pods
  744  k log frontend-prod-74bb76689d-zg822 -f
  745  k log frontend-prod-74bb76689d-zg822 -f -c istio-proxy
  746  k log frontend-prod-74bb76689d-zg822 -f -c frontend
  747  kubectl exec -it frontend-prod-74bb76689d-zg822 /bin/sh
  748  k get pod
  749  k edit pod frontend-prod-74bb76689d-zg822
  750  k edit virtualservice frontend
  751  k edit service frontend
  752  k get service
  753  k get virtualservice
  754  k get virtualservice -o yaml
  755  k edit virtualservice frontend
  756  k get pods
  757  k describe pod frontend-prod-74bb76689d-zg822
  758  k get pods
  759  k get virtualservice --all-namespaces
  760  k get virtualservice --all-namespaces
  761  k get virtualservice frontend -n coop-dev
  762  k get virtualservice frontend -n coop-dev -o yam
  763  k get virtualservice frontend -n coop-dev -o yaml
  764  kubens coop-dev
  765  k get virtualservice
  766  k delete virtualservice frontend
  767  kubens -
  768  curl -v https://stratis-test.azure-api.net/accessdemo/healthcheck/ping
  769  k get gw
  770  k get gw  my-gateway -o yaml
  771  k get virtualservice
  772  k get virtualservice frontend -o yaml
  773  history


  494  k describe svc istio-ingressgateway -n istio-system
   495  k describe virtualservice openbanking
   496  k get svc -o istio-system
   497  k get svc -n istio-system
   498  k get pod -n istio-system
   499  k log istio-ingressgateway-5f577bbbcd-87kzf -n istio-system -f
   500  k log istio-ingressgateway-5f577bbbcd-87kzf -n istio-system -f
   501*
   502  k edit service istio-gateway -n istio-system
   503  k edit service istio-ingressgateway -n istio-system
   504  k edit service istio-gateway -n istio-system
   505  k
   506  k show service -n istio-system
   507  k get service -n istio-system
   508  watch kubectl get service -n istio-system
   509  k edit service istio-gateway -n istio-system
   510  k edit service istio-ingressgateway -n istio-system
   511  k edit service istio-ingressgateway -n istio-system
   512  k get ervice
   513  k get service
   514  kx -
   515  k get service
   516  k get service
   517  k get svc -n istio-system
   518  k get pod -n istio-system
   519  kubectl port-forward istio-ingressgateway-56556449d9-sv24f 15000
   520  kubectl port-forward istio-ingressgateway-56556449d9-sv24f 15000 -n istio-system
   521  ps aux |grep port
   522  ps aux |grep forward```
