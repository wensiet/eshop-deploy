SECRET_NAME=gitlab
REGISTRY_HOST=registry.gitlab.com
REGISTRY_USERNAME=wensiet
REGISTRY_EMAIL=wensietyt@gmail.com

.PHONY: create-secret

create-secret:
	@read -p "Enter Docker Registry Token: " token; \
	kubectl create secret docker-registry $(SECRET_NAME) \
	  --docker-server=$(REGISTRY_HOST) \
	  --docker-username=$(REGISTRY_USERNAME) \
	  --docker-password=$$token \
	  --docker-email=$(REGISTRY_EMAIL)