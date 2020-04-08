#!/bin/bash
set -e

# fix the webify_models_v2.py script
# cp /.dockerinstall/webify_models_v2.py /opt/gzweb/webify_models_v2.py

source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"

DIR_DESCRIPTION="/ros_ws/src/turtlebot3/turtlebot3_description"
DIR_ROBOTS="${DIR_DESCRIPTION}/robots"
mkdir -p "${DIR_ROBOTS}"

function prepare_robot {
  name=$1
  echo "preparing robot: ${name}"

  xacro="${DIR_DESCRIPTION}/urdf/${name}.urdf.xacro"
  dir="${DIR_ROBOTS}/${name}"
  urdf="${dir}/${name}.urdf"
  
  mkdir -p "${dir}"
  ln -s "${DIR_DESCRIPTION}/meshes" "${dir}/meshes"
  xacro --inorder "${xacro}" | sed "s#package://turtlebot3_description#${dir}#g" > "${urdf}"

  # create robot config
  echo "<?xml version="1.0"?>
  <model>
  <name>${name}</name>
  <version>1.0</version>
  <sdf version="1.4">$(basename "${urdf}")</sdf>
  </model>" > "${dir}/model.config"

  echo "prepared robot: ${name}"
}

prepare_robot turtlebot3_burger
prepare_robot turtlebot3_burger_for_autorace
prepare_robot turtlebot3_waffle
prepare_robot turtlebot3_waffle_for_open_manipulator
prepare_robot turtlebot3_waffle_pi
prepare_robot turtlebot3_waffle_pi_for_open_manipulator

# update the launch files
DIR_GAZEBO="/ros_ws/src/turtlebot3_simulations/turtlebot3_gazebo"
ORIGINAL_ARG="urdf/turtlebot3_\$(arg model).urdf.xacro"
UPDATED_ARG="robots/turtlebot3_\$(arg model)/turtlebot3_\$(arg model).urdf"
find "${DIR_GAZEBO}/launch" -name *.launch -exec sed -i "s#${ORIGINAL_ARG}#${UPDATED_ARG}#g" {} \;

# deploy the models!
export GAZEBO_MODEL_PATH="${DIR_ROBOTS}:${GAZEBO_MODEL_PATH}"
echo "deplyoing models using GAZEBO_MODEL_PATH: ${GAZEBO_MODEL_PATH}"
/opt/gzweb/deploy.sh -m local
