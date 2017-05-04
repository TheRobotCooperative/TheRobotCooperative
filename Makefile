SHELL=/bin/bash

ROBOTS = jackal grizzly cob4 fetch kobuki nao

all = $(ROBOTS)

$(ROBOTS):
	docker build -t squareslab/robots:$@ $@

push:
	docker push squareslab/robots:jackal

.PHONY: $(ROBOTS) push
