SHELL=/bin/bash

ROBOTS = jackal grizzly cob4

all = $(ROBOTS)

$(ROBOTS):
	docker build -t squareslab/robots:$@ $@

push:
	docker push squareslab/robots:jackal

.PHONY: $(ROBOTS) push
