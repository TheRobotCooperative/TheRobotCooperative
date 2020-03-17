all = baxter cob4 fanuc fetch heron husky nao pr2 turtlebot warthog

baxter:
	docker build --build-arg DISTRO=indigo --build-arg ROSINSTALL_FILE=baxter/pkgs.rosinstall -t baxter .

cob4:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=cob4/pkgs.rosinstall -t cob4 .

fanuc:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=fanuc/pkgs.rosinstall -t fanuc .

fetch:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=fetch/pkgs.rosinstall -t fetch .

heron:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=heron/pkgs.rosinstall -t heron .

husky:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=husky/pkgs.rosinstall -t husky .

nao:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=nao/pkgs.rosinstall -t nao .

pr2:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=pr2/pkgs.rosinstall -t pr2 .

turtlebot:
	docker build --build-arg DISTRO=kinetic --build-arg ROSINSTALL_FILE=turtlebot/pkgs.rosinstall -t turtlebot .

warthog:
	docker build --build-arg DISTRO=melodic --build-arg ROSINSTALL_FILE=warthog/pkgs.rosinstall -t warthog .

.PHONY: baxter cob4 fanuc fetch heron husky nao pr2 turtlebot warthog
