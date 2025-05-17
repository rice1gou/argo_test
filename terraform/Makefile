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
	cd core && terraform init -upgrade -backend-config backend.tfvars

.PHONY: _terraform.plan
_terraform.plan:
	cd core && terraform plan -var-file=variables.tfvars

.PHONY: _terraform.apply
_terraform.apply:
	cd core && terraform apply -var-file=variables.tfvars

.PHONY: _terraform.destroy
_terraform.destroy:
	cd core && terraform destroy -var-file=variables.tfvars


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

#############################
# destroy
#############################
.PHONY: terraform.destroy
terraform.destroy:
	@make _terraform.destroy