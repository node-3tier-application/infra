PLAN_FILE?=/tmp/plan

plan:
	terraform plan -out ${PLAN_FILE}

exec: plan
	terraform apply ${PLAN_FILE}

output:
	terraform output

get-kubeconfig:
	gcloud container clusters \
		get-credentials "$(shell terraform output cluster_name)" \
		--region "$(shell terraform output region)" \
		--project "$(shell terraform output project_id)"
