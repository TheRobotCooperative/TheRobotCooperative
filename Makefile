all = baxter cob4 fetch turtlebot

baxter:
	docker build --build-arg DISTRO=indigo --build-arg ROSINSTALL_FILE=baxter/pkgs.rosinstall -t baxter .

cob4:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=cob4/pkgs.rosinstall -t cob4 .

fetch:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=fetch/pkgs.rosinstall -t fetch .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=turtlebot/pkgs.rosinstall -t turtlebot .

.PHONY: baxter cob4 fetch turtlebot
