#!/bin/bash
roslaunch /ros_ws/src/cob_simulation/cob_gazebo/launch/robot.launch \
    gui:=false \
    robot:=cob4-9 \
    robot_env:=ipa-apartment
