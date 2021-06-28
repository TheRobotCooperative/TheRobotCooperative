#!/bin/bash
set -e
source "/opt/ros/${ROS_DISTRO}/setup.bash"

if [ -f "/ros_ws/devel/setup.bash" ]; then
  source "/ros_ws/devel/setup.bash"
elif [ -f "/ros_ws/devel_isolated/setup.bash" ]; then
  source "/ros_ws/devel_isolated/setup.bash"
else
  echo "Failed to find appropriate setup.bash in /ros_ws"
  exit 1
fi

exec "$@"
