#!/bin/bash
set -e

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

DIR_DESCRIPTION="/ros_ws/src/autorally/autorally_description"
DIR_URDF="${DIR_DESCRIPTION}/urdf"
DIR_MODELS="${DIR_URDF}/models"

# fix the SDF files
find "${DIR_MODELS}" -name *.sdf -exec sed -i "s#model://urdf#${DIR_URDF}#g" {} \;

# deploy the models
export GAZEBO_MODEL_PATH="/ros_ws/src/autorally/autorally_description/urdf/models:${GAZEBO_MODEL_PATH}"
echo "deploying models using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
