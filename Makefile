all = cob4 turtlebot

cob4:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=cob4/pkgs.rosinstall -t cob4 .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=turtlebot/pkgs.rosinstall -t turtlebot .

.PHONY: cob4 turtlebot
