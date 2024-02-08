SECRET_NAME_GITLAB=gitlab
REGISTRY_HOST=registry.gitlab.com
REGISTRY_USERNAME=wensiet
REGISTRY_EMAIL=wensietyt@gmail.com

SECRET_NAME_YANDEX=yandex-cloud-registry
YANDEX_USERNAME=oauth
YANDEX_HOST=cr.yandex

gitlab:
	@read -p "Enter Kubernetes Namespace: " namespace; \
    read -p "Enter Gitlab Registry Token: " token; \
	kubectl create secret --namespace $$namespace docker-registry $(SECRET_NAME_GITLAB) \
	  --docker-server=$(REGISTRY_HOST) \
	  --docker-username=$(REGISTRY_USERNAME) \
	  --docker-password=$$token \
	  --docker-email=$(REGISTRY_EMAIL)

yandex:
	@read -p "Enter Kubernetes Namespace: " namespace; \
    read -p "Enter Yandex Registry Token: " token; \
    kubectl create secret --namespace $$namespace docker-registry $(SECRET_NAME_YANDEX) \
      --docker-server=$(YANDEX_HOST) \
      --docker-username=$(YANDEX_USERNAME) \
      --docker-password=$$token \
      --docker-email=$(REGISTRY_EMAIL)