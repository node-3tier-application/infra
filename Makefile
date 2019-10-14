PROJECT_ID?=node-3tier-application
TF_USER?=terraform
TF_ADMIN?=${TF_USER}@${PROJECT_ID}
TF_CREDS?=~/.config/gcloud/${TF_ADMIN}.json

create_project:
	gcloud projects create ${PROJECT_ID}  --set-as-default

create_user:
	gcloud iam service-accounts create ${TF_USER} \
	  --display-name "Terraform Admin Account" \

generate_key:
	gcloud iam service-accounts keys create ${TF_CREDS} \
	  --iam-account ${TF_ADMIN}.iam.gserviceaccount.com


attach_permission:
	echo 'THIS THING IS BUGGY !!!, #TODO, #reviselater'
	echo 'Create a user from gcloud console and move on...'
	echo '
	gcloud projects add-iam-policy-binding ${PROJECT_ID} \
	  --member serviceAccount:${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/owner

	gcloud projects add-iam-policy-binding ${PROJECT_ID} \
	  --member serviceAccount:${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/serviceusage.serviceUsageAdmin
	'

configure_user: create_user generate_key attach_permission

enable-gcloud-resources:
	gcloud services enable cloudresourcemanager.googleapis.com --project ${PROJECT_ID}
	gcloud services enable compute.googleapis.com --project ${PROJECT_ID}
	gcloud services enable container.googleapis.com --project ${PROJECT_ID}

#-----------------------------------------
## !!!   DESTRUCTIVE COMMANDS !!!!      ## 
## WARNING, this might break you down   ##
#-----------------------------------------
deconfigure_user:
	gcloud iam service-accounts delete \
	${TF_USER}@${PROJECT_ID}.iam.gserviceaccount.com
