#!/bin/bash
set -e

# fix the webify_models_v2.py script
cp /.dockerinstall/webify_models_v2.py /opt/gzweb/webify_models_v2.py

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

# a bug in the gzweb deploy script prevents the following file from working:
rm /opt/ros/kinetic/share/gazebo_plugins/Media/models/chair/textures.txt

function fix_uuv_model {
  model_name=$1
  model_dir="/ros_ws/src/uuv_simulator/uuv_gazebo_worlds/models/${model_name}"
  echo "fixing UUV model: ${model_name}"
  ln -s /ros_ws/src/uuv_simulator/uuv_gazebo_worlds/Media/materials "${model_dir}/materials"
  ln -s /ros_ws/src/uuv_simulator/uuv_gazebo_worlds/Media/models "${model_dir}/models"
  sed -i "s#file://Media/#model://${model_name}/#g" "${model_dir}/model.sdf"
}

# fix uuv models
pushd /ros_ws/src/uuv_simulator/uuv_gazebo_worlds/models
for uuv_model in *; do
  fix_uuv_model "${uuv_model}"
done
popd

# deploy the models!
export GAZEBO_MODEL_PATH="$(dirname ${ROBOT_DIR}):${GAZEBO_MODEL_PATH}"
export GAZEBO_MODEL_PATH="/ros_ws/src/uuv_simulator/uuv_gazebo_worlds/models:${GAZEBO_MODEL_PATH}"
echo "using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
