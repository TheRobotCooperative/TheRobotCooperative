all = autorally baxter cob4 fanuc fetch f1tenth f1tenth_tutorial guardian heron husky husky_waypoints nao pallet_truck pr2 rbcar rb1 rb2 summit_xl turtlebot turtlebot3 warthog

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

guardian:
	docker build --build-arg BUILD_COMMAND="catkin_make" --build-arg DISTRO=indigo --build-arg DIRECTORY=guardian -t guardian .

f1tenth:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=f1tenth -t f1tenth .

f1tenth_tutorial:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=f1tenth_tutorial -t f1tenth_tutorial .

heron:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=heron -t heron .

husky:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=husky -t husky .

husky_waypoints:
	docker build --build-arg BUILD_COMMAND="catkin_make" --build-arg BUILD_COMMAND="catkin_make_isolated" --build-arg DISTRO=melodic --build-arg DIRECTORY=husky_waypoints -t husky_waypoints .

nao:
	docker build --build-arg DISTRO=indigo --build-arg DIRECTORY=nao -t nao .

pallet_truck:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=kinetic --build-arg DIRECTORY=pallet_truck -t pallet_truck .

pr2:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=pr2 -t pr2 .

rbcar:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=rbcar -t rbcar .

rb1:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=melodic --build-arg DIRECTORY=rb1 -t rb1 .

rb2:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=melodic --build-arg DIRECTORY=rb2 -t rb2 .

summit_xl:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=kinetic --build-arg DIRECTORY=summit_xl -t summit_xl .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=turtlebot -t turtlebot .

turtlebot3:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=turtlebot3 -t turtlebot3 .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=warthog -t warthog .

.PHONY: autorally baxter cob4 fanuc fetch f1tenth f1tenth_tutorial guardian heron husky husky_waypoints nao pallet_truck pr2 rbcar rb1 rb2 summit_xl turtlebot turtlebot3 warthog
