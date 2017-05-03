SHELL=/bin/bash

all = jackal

jackal:
	docker build -t christimperley/robots:jackal jackal

push:
	docker push christimperley/robots:jackal

.PHONY: jackal push
