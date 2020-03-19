all = baxter cob4 fanuc fetch f1tenth heron husky nao pr2 turtlebot warthog

baxter:
	docker build --build-arg DISTRO=indigo --build-arg DIRECTORY=baxter -t baxter .

cob4:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=cob4 -t cob4 .

fanuc:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=fanuc -t fanuc .

fetch:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=fetch -t fetch .

f1tenth:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=f1tenth -t f1tenth .

heron:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=heron -t heron .

husky:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=husky -t husky .

nao:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=nao -t nao .

pr2:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=pr2 -t pr2 .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=turtlebot -t turtlebot .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=warthog -t warthog .

.PHONY: baxter cob4 fanuc fetch f1tenth heron husky nao pr2 turtlebot warthog
