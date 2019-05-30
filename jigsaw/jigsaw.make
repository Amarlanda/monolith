#alias \\z="make -f /home/aj/monolith/jigsaw/jigsaw.make"

install azure autocomplete:
	_python_argcomplete() {
	    local IFS=$'\013'
	    local SUPPRESS_SPACE=0
	    if compopt +o nospace 2> /dev/null; then
	        SUPPRESS_SPACE=1
	    fi
	    COMPREPLY=( $(IFS="$IFS" \
	                  COMP_LINE="$COMP_LINE" \
	                  COMP_POINT="$COMP_POINT" \
	                  COMP_TYPE="$COMP_TYPE" \
	                  _ARGCOMPLETE_COMP_WORDBREAKS="$COMP_WORDBREAKS" \
	                  _ARGCOMPLETE=1 \
	                  _ARGCOMPLETE_SUPPRESS_SPACE=$SUPPRESS_SPACE \
	                  "$1" 8>&1 9>&2 1>/dev/null 2>/dev/null) )
	    if [[ $? != 0 ]]; then
	        unset COMPREPLY
	    elif [[ $SUPPRESS_SPACE == 1 ]] && [[ "$COMPREPLY" =~ [=/:]$ ]]; then
	        compopt -o nospace
	    fi
	}
	complete -o nospace -F _python_argcomplete "az"

azure login:
	#azure-cli

aws-login:
	echo "user authetication for aws"
	aws sts get-caller-identity
	aws --version
	rm -rf ~aj/.kube/
	aws eks --region eu-west-1 update-kubeconfig --name atlas
	aws eks list-clusters

	kubectl config view
	kubectl get svc

lee:
	deploy-stuff:
		kubectl apply -f ./configs/kube/services.yaml
		-sed -e 's~<PROJECT_ID>~$(PROJECT_ID)~g' ./configs/kube/deployments.yaml | kubectl apply -f -
	get-stuff:
		kubectl get pods && kubectl get svc && kubectl get svc istio-ingressgateway -n istio-system

	ingress:
		kubectl apply -f ./configs/istio/ingress.yaml
	egress:
		kubectl apply -f ./configs/istio/egress.yaml
	prod:
		kubectl apply -f ./configs/istio/destinationrules.yaml
		kubectl apply -f ./configs/istio/routing-1.yaml
	retry:
		kubectl apply -f ./configs/istio/routing-2.yaml
	canary:
		kubectl apply -f ./configs/istio/routing-3.yaml
buildocker:
$(aws ecr get-login --no-include-email --region eu-west-1)
#docker build -t coop /home/aj/monolith/stuff/lab/Istio101/code/code-only-istio
#docker tag coop:aplinetest 355555488900.dkr.ecr.eu-west-1.amazonaws.com/coop:aplinetest
#docker push 355555488900.dkr.ecr.eu-west-1.amazonaws.com/coop:aplinetest

quay.io/ajmashh/k8-sample:istiotest
sh-login:
	cd /home/aj/Downloads/util_aws_login/

	cd /home/aj/monolith/stuff/lab/Istio101/configs
