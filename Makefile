all = autorally baxter cob4 fanuc fetch f1tenth heron husky nao pallet_truck pr2 rbcar rb1 turtlebot turtlebot3 warthog

autorally:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=autorally -t autorally .

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

pallet_truck:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=kinetic --build-arg DIRECTORY=pallet_truck -t pallet_truck .

pr2:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=pr2 -t pr2 .

rbcar:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=rbcar -t rbcar .

rb1:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=melodic --build-arg DIRECTORY=rb1 -t rb1 .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=turtlebot -t turtlebot .

turtlebot3:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=turtlebot3 -t turtlebot3 .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=warthog -t warthog .

.PHONY: autorally baxter cob4 fanuc fetch f1tenth heron husky nao pallet_truck pr2 rbcar rb1 turtlebot turtlebot3 warthog
