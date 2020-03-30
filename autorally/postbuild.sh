#!/bin/bash
set -e

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

# TODO update the models in autorally_description

export GAZEBO_MODEL_PATH="/ros_ws/src/autorally/autorally_description/urdf/models:${GAZEBO_MODEL_PATH}"
echo "deploying models using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
