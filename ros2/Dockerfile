# This is a generic Dockerfile that is used to build all of the images within
# the dataset. To do so, the Dockerfile relies on the use of build arguments
# and the copying of additional scripts from the directory of the robot that
# is being built.
#
# Build arguments
# ---------------
# BUILD_COMMAND: the command that should be used to build the Catkin workspace.
#   By default, catkin_make is used, but one may also use "catkin build"
#   instead as a means of avoiding certain build issues.
# DISTRO: specifies the ROS distribution that should be used by the base image
# DIRECTORY: specifies the directory that provides files for the robot
#
# References
# ----------
# * http://blog.fx.lv/2017/08/running-gui-apps-in-docker-containers-using-vnc
# * https://qxf2.com/blog/view-docker-container-display-using-vnc-viewer
# * https://github.com/ConSol/docker-headless-vnc-container/blob/master/src/ubuntu/install/libnss_wrapper.sh
# * https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04
# * https://hackernoon.com/installation-of-vnc-server-on-ubuntu-1cf035370bd3
# * https://www.tecmint.com/install-and-configure-vnc-server-on-ubuntu
# * https://stackoverflow.com/questions/48601146/docker-how-to-set-tightvncserver-password
ARG DISTRO

# NOTE: We need to install the cmake_modules to avoid some build failures
# that are due to unspecified dependencies.
# (https://github.com/ros-industrial/industrial_calibration/issues/50)
# supervisor
FROM ros:${DISTRO} AS main
ENV DEBIAN_FRONTEND noninteractive
ENV RTI_NC_LICENSE_ACCEPTED yes
ENV RTI_VERSION 5.3.1

COPY rootfs /
WORKDIR /ros_ws
ENTRYPOINT ["/ros_ws/entrypoint.sh"]
CMD ["/bin/bash"]
RUN mv /etc/apt/sources.list.d/ros2-latest.list ~
RUN apt update && apt install -y --no-install-recommends \
      apt-utils \
      bzip2 \
      cmake \
      build-essential \
      ca-certificates \
      curl \
      gcc \
      g++ \
      mercurial \
      python3-pip \
      software-properties-common \
      tmux \
      vim \
      wget 
RUn curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
 && wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -  \
 && echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list \
 && echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list \
 && wget http://packages.ros.org/ros.key -O - | apt-key add - \
 && apt-get update \
 && pip install setuptools \
 && pip install \
      coverage==5.1 \
      rosinstall-generator==0.1.18 \
      vcstool==0.2.10 \
      wstool==0.1.17 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install vncserver
RUN apt-get update \
 && apt-get install -y \
      supervisor \
      tightvncserver \
      xfce4 \
      xfce4-goodies \
      xfce4-terminal \
      xserver-xorg-core \
      xterm \
      xvfb \
      x11vnc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir ~/.vnc \
 && /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

RUN apt-get update \
  && apt install -y \
    gazebo11 \
    libgazebo11-dev 
RUN mv ~/ros2-latest.list /etc/apt/sources.list.d/ros2-latest.list && apt-get update
RUN apt install -y    ros-${ROS_DISTRO}-gazebo-ros-pkgs \
    rti-connext-dds-${RTI_VERSION} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mv /rticommon_config.sh /opt/rti.com/rti_connext_dds-${RTI_VERSION}/resource/scripts/rticommon_config.sh
      # Make the default workspace somewhere other than /root, and do not copy the examples

# build package
# We don't want to copy all of the contents of ${DIRECTORY} in this step
# because the build is very long and we may only be changing files
# relevant to the next step.
# The '*' here allows apt.list to be optional: 
# https://stackoverflow.com/questions/31528384/conditional-copy-add-in-dockerfile
ARG DIRECTORY
COPY "${DIRECTORY}"/pkgs.rosinstall "${DIRECTORY}"/apt.list* /.dockerinstall/
RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
 && mv /.dockerinstall/pkgs.rosinstall /ros_ws/pkgs.rosinstall \
 && apt-get update \
 && (test -f /.dockerinstall/apt.list \
     && xargs -a /.dockerinstall/apt.list apt-get install -y --no-install-recommends \
     || exit 0) \
 && wstool init -j8 src pkgs.rosinstall \
 && rosdep update \
 && rosdep install -i -y -r --from-paths src \
      --ignore-src \
      --skip-keys="python-rosdep python-catkin-pkg python-rospkg" \
      --rosdistro="${ROS_DISTRO}" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY "${DIRECTORY}" /.dockerinstall/
RUN apt-get update\
 && (test -f /.dockerinstall/prebuild.sh \
     && (echo "running prebuild step..." && /bin/bash /.dockerinstall/prebuild.sh || exit 1) \
     || (echo "skipping prebuild step [no prebuild.sh]" && exit 0)) \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
 && colcon build --executor parallel 
RUN chown -R root:root /root
