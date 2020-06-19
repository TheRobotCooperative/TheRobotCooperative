DOCKERHUB_ORG := therobotcooperative

all = turtlebot3

turtlebot3:
	docker build --build-arg DISTRO=crystal --build-arg DIRECTORY=robots/$@ -t ${DOCKERHUB_ORG}/$@-ros2 .

.PHONY: turtlebot3
