#!/bin/bash
cat >> ~/.bashrc <<- EOM
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/ros_ws/src/turtlebot3_simulations/turtlebot3_gazebo/models/
export TURTLEBOT3_MODEL=waffle_pi
source /opt/ros/${ROS_DISTRO}/setup.bash
source /ros_ws/install/setup.bash
EOM

cp /.dockerinstall/map.yaml /root/map.yaml
cp /.dockerinstall/map.pgm /root/map.pgm