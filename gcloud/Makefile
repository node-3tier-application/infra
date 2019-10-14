generate-api-secrets:
	@kubectl create secret generic api-secrets  --from-literal "POSTGRES_URL=$(shell terraform output database_url)" --from-literal "NODE_ENV=production"
	@kubectl describe secret/api-secrets

generate-web-secrets:
	@kubectl create secret generic web-secrets  --from-literal "API_HOST=http://api" --from-literal "NODE_ENV=production" --from-literal "CDN_URL=//assets.thisthing.works"
	@kubectl describe secret/web-secrets

genreate-secrets: generate-web-secrets generate-api-secrets

clean: clean_states
	rm -rf ~/.kube/config

clean_states:
	@terraform state rm google_compute_network.vpc_default

config_set:
	@gcloud config set project $(shell terraform output project_id)
	@gcloud config set compute/region $(shell terraform output region)
	gcloud config configurations list
