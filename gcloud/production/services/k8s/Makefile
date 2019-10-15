PLAN_FILE?=/tmp/plan

plan:
	terraform plan -out ${PLAN_FILE}

imports:
	@terraform import -provider=google-beta \
		module.db.google_compute_network.vpc_default default
exec:
	terraform apply ${PLAN_FILE}

run: imports plan exec


##---------------------------------------------
###  output section                         ###
##---------------------------------------------
output:
	terraform output

get-kubeconfig:
	gcloud container clusters \
		get-credentials "$(shell terraform output cluster_name)" \
		--region "$(shell terraform output region)" \
		--project "$(shell terraform output project_id)"

##----------------------------------------------
###  secrets sections                        ###
##----------------------------------------------
generate-api-secrets:
	@kubectl create secret generic api-secrets  --from-literal "POSTGRES_URL=$(shell terraform output database_url)" --from-literal "NODE_ENV=production"
	@kubectl describe secret/api-secrets

generate-web-secrets:
	@kubectl create secret generic web-secrets  --from-literal "API_HOST=http://api" --from-literal "NODE_ENV=production" --from-literal "CDN_URL=//assets.thisthing.works"
	@kubectl describe secret/web-secrets

generate-secrets: generate-web-secrets generate-api-secrets


#-------------------------------------------------
###  DESTRUCTIVE COMMAND                        ###
#-------------------------------------------------
clean: clean_imports
	terraform destroy

clean_imports:
	terraform state rm module.db.google_compute_network.vpc_default
