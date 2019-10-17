CLUSTER_NAME?=$(shell cd ../gcloud/production/services/k8s; terraform output cluster_name)
REGION?=$(shell cd ../gcloud/production/services/k8s; terraform output region)
PROJECT_ID?=$(shell cd ../gcloud/production/services/k8s; terraform output project_id)

create-gitlab-svc-account:
	@kubectl apply -f gitlab-admin-service-account.yml

##---------------------------------------------
###         PROMETHEUS.*                    ###
##---------------------------------------------
deploy_prom:
	helm install \
		--name prom \
		--namespace observability \
		-f prom_custom_values.yml \
		stable/prometheus-operator

proxy:
	kubectl port-forward -n observability svc/prom-grafana 8080:80


##---------------------------------------------
###         HELM SECTION                    ###
##---------------------------------------------
.PHONY: helm
helm-init: create_helm_tiller_svc_account
	helm init --upgrade --service-account tiller

create_helm_tiller_svc_account:
	@kubectl apply -f helm-tiller.yml

check_helm_working:
	helm version

loki:
	helm repo add loki https://grafana.github.io/loki/charts
	helm repo update
	helm install --name loki --namespace observability loki/loki-stack
