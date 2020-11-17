DOCKERHUB_ORG := therobotcooperative

all = autorally baxter cob4 fanuc fetch f1tenth f1tenth_tutorial guardian heron husky nao pallet_truck pr2 rbcar rb1 rb2 summit_xl turtlebot turtlebot3 warthog

autorally:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

baxter:
	docker build --build-arg DISTRO=indigo --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

chatter:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

cob4:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

fanuc:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

fetch:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

guardian:
	docker build --build-arg BUILD_COMMAND="catkin_make" --build-arg DISTRO=indigo --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

f1tenth:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

f1tenth_tutorial:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

heron:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

husky:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

nao:
	docker build --build-arg DISTRO=indigo --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

pallet_truck:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

pr2:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

rbcar:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

rb1:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

rb2:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

summit_xl:
	docker build --build-arg BUILD_COMMAND="catkin build" --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

turtlebot3:
	docker build --build-arg DISTRO=kinetic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

turtlesim:
	docker build --build-arg BUILD_COMMAND="catkin_make_isolated" --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@ .

oceanworld:
	docker build --build-arg DISTRO=melodic --build-arg DIRECTORY=robots/$@ --build-arg BUILD_COMMAND="(. ~/.profile; catkin_make)" -t ${DOCKERHUB_ORG}/$@ .

.PHONY: autorally baxter chatter cob4 fanuc fetch f1tenth f1tenth_tutorial guardian heron husky nao pallet_truck pr2 rbcar rb1 rb2 summit_xl turtlebot turtlebot3 warthog
