SHELL=/bin/bash

all = jackal

jackal:
	docker build -t squareslab/robots:jackal jackal

push:
	docker push squareslab/robots:jackal

.PHONY: jackal push
