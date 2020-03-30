#!/bin/bash
set -e

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

DIR_DESCRIPTION="/ros_ws/src/rbcar_common/rbcar_description"
DIR_ROBOTS="${DIR_DESCRIPTION}/robots"
DIR_RBCAR="${DIR_ROBOTS}/rbcar"

# create robot directory
mkdir -p "${DIR_RBCAR}"

# link meshes
ln -s "${DIR_DESCRIPTION}/meshes" "${DIR_RBCAR}/meshes"

# move and fix URDF file
mv "${DIR_ROBOTS}/rbcar.urdf" "${DIR_RBCAR}/rbcar.urdf"
sed -i "s#package://rbcar_description/#${DIR_RBCAR}#g" "${DIR_RBCAR}/rbcar.urdf"

# create robot config
echo "<?xml version="1.0"?>
<model>
<name>rbcar</name>
<version>1.0</version>
<sdf version="1.4">rbcar.urdf</sdf>
</model>" > "${DIR_RBCAR}/model.config"

# fix the launch file
ORIGINAL_ARG="'\$(find rbcar_description)/robots/rbcar.urdf.xacro'"
UPDATED_ARG="'\$(find rbcar_description)/robots/rbcar/rbcar.urdf'"
SED_ARG="s#${ORIGINAL_ARG}#${UPDATED_ARG}#g"
sed -i "${SED_ARG}" "${DIR_DESCRIPTION}/launch/rbcar_rviz.launch"
sed -i "${SED_ARG}" "${DIR_DESCRIPTION}/launch/rbcar_state_robot.launch"

# deploy the models!
export GAZEBO_MODEL_PATH="${DIR_ROBOTS}:${GAZEBO_MODEL_PATH}"
echo "deplyoing models using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
