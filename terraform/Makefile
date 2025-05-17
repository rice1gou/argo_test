SHELL=/bin/bash

#############################
# command
#############################
.PHONY: _terraform.setup
_terraform.setup:
	cd init && \
	terraform init && \
	terraform apply -var-file=variables.tfvars && \
	terraform init -migrate-state

.PHONY: _terraform.init
_terraform.init:
	terraform init -upgrade -backend-config backend.tfvars

.PHONY: _terraform.plan
_terraform.plan:
	terraform plan -var-file=terraform.tfvars

.PHONY: _terraform.apply
_terraform.apply:
	terraform apply -var-file=terraform.tfvars


#############################
# setup
#############################
.PHONY: terraform.setup
terraform.setup:
	@make _terraform.setup

#############################
# init
#############################
.PHONY: terraform.init
terraform.init:
	@make _terraform.init

#############################
# plan
#############################
.PHONY: terraform.plan
terraform.plan:
	@make _terraform.plan

#############################
# apply
#############################
.PHONY: terraform.apply
terraform.apply:
	@make _terraform.apply