all = baxter cob4 fetch heron turtlebot warthog

baxter:
	docker build --build-arg DISTRO=indigo --build-arg ROSINSTALL_FILE=baxter/pkgs.rosinstall -t baxter .

cob4:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=cob4/pkgs.rosinstall -t cob4 .

fetch:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=fetch/pkgs.rosinstall -t fetch .

heron:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=heron/pkgs.rosinstall -t heron .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=turtlebot/pkgs.rosinstall -t turtlebot .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=warthog/pkgs.rosinstall -t warthog .

.PHONY: baxter cob4 fetch heron turtlebot warthog
