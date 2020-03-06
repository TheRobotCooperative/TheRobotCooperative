ARG DISTRO
FROM ros:${DISTRO}

WORKDIR /ros_ws
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      apt-utils \
      ca-certificates \
      vim \
      software-properties-common \
      wget \
      curl \
      g++ \
      gcc \
      python-pip \
 && echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list \
 && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
 && echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list \
 && wget http://packages.ros.org/ros.key -O - | apt-key add - \
 && apt-get update \
 && pip install \
      catkin-tools==0.4.5 \
      rosinstall-generator==0.1.18 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# add entrypoint
ENV ROS_WSPACE /ros_ws
WORKDIR "${ROS_WSPACE}"
RUN echo "#!/bin/bash \n\
set -e \n\
source \"/opt/ros/\${ROS_DISTRO}/setup.bash\" \n\
source \"${ROS_WSPACE}/devel/setup.bash\" \n\
exec \"\$@\"" > "${ROS_WSPACE}/entrypoint.sh" \
 && chmod +x "${ROS_WSPACE}/entrypoint.sh"
ENTRYPOINT ["/ros_ws/entrypoint.sh"]
CMD ["/bin/bash"]

# build package
COPY pkgs.rosinstall /ros_ws
RUN wstool init -j8 src pkgs.rosinstall \
 && . /opt/ros/${ROS_DISTRO}/setup.sh \
 && apt-get update \
 && rosdep update \
 && rosdep install -i -y -r --from-paths src \
      --ignore-src \
      --skip-keys="python-rosdep python-catkin-pkg python-rospkg" \
      --rosdistro="${ROS_DISTRO}" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
 && catkin build
