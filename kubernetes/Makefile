CLUSTER_NAME?=$(shell cd ../gcloud/production/services/k8s; terraform output cluster_name)
REGION?=$(shell cd ../gcloud/production/services/k8s; terraform output region)
PROJECT_ID?=$(shell cd ../gcloud/production/services/k8s; terraform output project_id)

create-gitlab-svc-account:
	@kubectl apply -f gitlab-admin-service-account.yml

create-helm-tiller-svc-account:
	@kubectl apply -f helm-tiller.yml

prometheus:
	helm install --name prom --namespace observability -f prom-custom-values.yaml stable/prometheus-operator

proxy:
	kubectl port-forward -n observability svc/prom-grafana 8080:80

.PHONY: helm
helm:
	helm repo add loki https://grafana.github.io/loki/charts
	helm repo update
	kubectl apply -f helm-tiller.yml
	helm init --upgrade --service-account tiller

loki:
	helm install --name loki --namespace observability loki/loki-stack

get-cluster-info:
	@echo "gitlab_vars"{
	@echo -n SERVER=
	@kubectl cluster-info|awk '/Kubernetes master/{print $$NF}'

	@echo -n CERTIFICATE_AUTHORITY_DATA=
	@gcloud container clusters describe $(CLUSTER_NAME) --region $(REGION) --project $(PROJECT_ID) |awk '/clusterCaCertificate/{print $$NF}'

	@echo -n USER_TOKEN=
	@kubectl describe secret $(shell kubectl -n kube-system get secret | awk '/gitlab-admin/{print $$1}') -n kube-system|awk '/token:/{print $$NF}'
	@echo "}"
