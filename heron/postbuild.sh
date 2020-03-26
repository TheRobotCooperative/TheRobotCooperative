#!/bin/bash
set -e

ROBOT_NAME=heron
MESHES_DIR="/ros_ws/src/heron/heron_description/meshes"
ROBOT_DIR="/ros_ws/src/heron/heron_description/robots/${ROBOT_NAME}"
XACRO_FILE="/ros_ws/src/heron/heron_description/urdf/heron.urdf.xacro"
URDF_FILE="${ROBOT_DIR}/heron.gazebo.urdf"
LAUNCH_FILE="/ros_ws/src/heron/heron_description/launch/description.launch"
MODEL_CONFIG_FILE="${ROBOT_DIR}/model.config"

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

# generate a pure URDF file
mkdir -p "${ROBOT_DIR}"
xacro --inorder "${XACRO_FILE}" > "${URDF_FILE}"
sed -i "s#heron_description#${ROBOT_NAME}#g" "${URDF_FILE}"
sed -i "s#package://${ROBOT_NAME}#${ROBOT_DIR}#g" "${URDF_FILE}"

# link the meshes
ln -s "${MESHES_DIR}" "${ROBOT_DIR}/meshes"

# create robot config
echo "<?xml version="1.0"?>
<model>
<name>${ROBOT_NAME}</name>
<version>1.0</version>
<sdf version="1.4">$(basename "${URDF_FILE}")</sdf>
</model>" > "${ROBOT_DIR}/model.config"

# update launch file
sed -i "s#urdf/heron.urdf.xacro#robots/${ROBOT_NAME}/$(basename ${URDF_FILE})#g" "${LAUNCH_FILE}"

# deploy the models!
export GAZEBO_MODEL_PATH="$(dirname ${ROBOT_DIR}):${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local 
