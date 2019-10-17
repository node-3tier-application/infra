PLAN_FILE?=/tmp/plan-gitlab

plan:
	terraform plan -out ${PLAN_FILE}

exec:
	terraform apply ${PLAN_FILE}

run: plan exec


##---------------------------------------------
###  output section                         ###
##---------------------------------------------
output:
	terraform output

#-------------------------------------------------
###  DESTRUCTIVE COMMAND                        ###
#-------------------------------------------------
clean:
	terraform destroy
