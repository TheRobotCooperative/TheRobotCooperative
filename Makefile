DOCKERHUB_ORG := therobotcooperative

all = ros1

ros1:
	$(MAKE) -C ros1

upload:
	docker image ls ${DOCKERHUB_ORG}/* --format "{{.Repository}}:{{.Tag}}" | \
	  xargs -n1 docker push

.PHONY: ros1 upload
