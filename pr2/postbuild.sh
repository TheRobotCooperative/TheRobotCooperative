#!/bin/bash
set -e

source "/opt/ros/kinetic/setup.bash"
source "/ros_ws/devel/setup.bash"

# first, we create a directory named after the robot to store its
# description and its associated meshes and materials
mkdir /ros_ws/src/pr2_common/pr2_description/robots/pr2

# next, we transform the Xacro file for the robot into a pure URDF file and
# store that file in the newly created robot directory
pushd /ros_ws/src/pr2_common/pr2_description/robots/pr2
xacro /ros_ws/src/pr2_common/pr2_description/robots/pr2.urdf.xacro --inorder KINECT1:=false KINECT2:=false > pr2.urdf
# we then need to transform all "package://" paths into "model://" paths to
# ensure gzweb compatibility
sed -i "s#package://#model://#g" pr2.urdf

# The meshes and
# materials for the robot are not stored in the same package as its Xacro
# file. Because of this, GzWeb will fail to locate and build those meshes.
# We rectify the situation by first symlinking the meshes directory into the
# newly created robot directory.
ln -s /ros_ws/src/pr2_common/pr2_description/meshes meshes

# We then update the URDF file to point to "pr2" (which is essentially
# a copy of the robot directory that we are creating)
sed -i "s#pr2_description#pr2#g" pr2.urdf

# To advertise our new robot model directory to GzWeb, we need to add a
# model.config file at its root.
# (CT slightly suspects that the contents of this file don't actually matter.)
echo "<?xml version="1.0"?>
<model>
<name>pr2</name>
<version>1.0</version>
<sdf version="1.4">pr2.urdf</sdf>
</model>" > model.config

# We also need to update the XML launch file for the Fetch simulator to use our
# new, pure URDF file

# WARNING: This line may not work for launch files where 'command' is not the
# last attribute on the line.
sed -i 's/command=".*"/command="cat $(find pr2_description)\/robots\/pr2\/pr2.urdf"/' /ros_ws/src/pr2_common/pr2_description/robots/upload_pr2.launch

# Almost done!
# We now update the Gazebo model path to include the robot directory that we
# just created, as well as some existing models that are used for the simulated
# environment. (Note that each model directory on the path should contain a
# model.config file.)
#
# BEWARE: the value of this environment variable will not persist beyond the lifetime
# of the shell.
export GAZEBO_MODEL_PATH="/ros_ws/src/pr2_common/pr2_description/urdf:${GAZEBO_MODEL_PATH}"
export GAZEBO_MODEL_PATH="/ros_ws/src/pr2_common/pr2_description/robots:${GAZEBO_MODEL_PATH}"

# Now that everything is in place, let's bake our models into the
# /opt/gzweb/http/client/assets directory:
/opt/gzweb/deploy.sh -m local
