#!/bin/bash
set -e

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

ROBOT_NAME="autorally"
DIR_DESCRIPTION="/ros_ws/src/autorally/autorally_description"
DIR_ROBOTS="${DIR_DESCRIPTION}/robots"
DIR_ROBOT="${DIR_ROBOTS}/${ROBOT_NAME}"
DIR_URDF="${DIR_DESCRIPTION}/urdf"
DIR_MODELS="${DIR_URDF}/models"
XACRO_FILE="${DIR_URDF}/autoRallyPlatform.urdf.xacro"
PURE_URDF_FILE="${DIR_ROBOT}/${ROBOT_NAME}.urdf"

# fix the SDF files
find "${DIR_MODELS}" -name *.sdf -exec sed -i "s#model://urdf#${DIR_URDF}#g" {} \;

# prepare the robot directory
mkdir -p "${DIR_ROBOT}"
echo "<?xml version="1.0"?>
<model>
<name>${ROBOT_NAME}</name>
<version>1.0</version>
<sdf version="1.4">$(basename ${PURE_URDF_FILE})</sdf>
</model>" > "${DIR_ROBOT}/model.config"
xacro --inorder "${XACRO_FILE}" > "${PURE_URDF_FILE}"
sed -i "s#package://autorally_description/urdf#${DIR_URDF}#g" "${PURE_URDF_FILE}"

# fix the launch file
SED_ARG="s#urdf/autoRallyPlatform.urdf.xacro#robots/${ROBOT_NAME}/${ROBOT_NAME}.urdf#g"
sed -i "${SED_ARG}" "${DIR_DESCRIPTION}/launch/autoRallyPlatform.launch"

# deploy the models
export GAZEBO_MODEL_PATH="${DIR_ROBOTS}:${DIR_MODELS}:${GAZEBO_MODEL_PATH}"
echo "deploying models using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
