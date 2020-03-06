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

# install gzweb deps
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      libjansson-dev \
      libboost-dev \
      imagemagick \
      libtinyxml-dev \
      mercurial \
      cmake \
      build-essential \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV NODE_PATH /opt/nodejs
ENV NODE_VERSION v6.17.1
ENV NODE_DISTRO linux-x64
ENV NODE_RELEASE "node-${NODE_VERSION}-${NODE_DISTRO}"
RUN cd /tmp \
 && wget -nv "https://nodejs.org/dist/${NODE_VERSION}/${NODE_RELEASE}.tar.xz" \
 && mkdir -p "${NODE_PATH}" \
 && tar -xJvf "${NODE_RELEASE}.tar.xz" -C "${NODE_PATH}" \
 && rm -f "${NODE_RELEASE}.tar.xz"
ENV PATH "${NODE_PATH}/${NODE_RELEASE}/bin:${PATH}"

# install gzweb
ENV GZWEB_PATH /opt/gzweb
ENV GZWEB_RELEASE gzweb_1.4.0
RUN hg clone https://bitbucket.org/osrf/gzweb "${GZWEB_PATH}" -u "${GZWEB_RELEASE}"

# install gazebo models
RUN cd "${GZWEB_PATH}" \
 && . /usr/share/gazebo/setup.sh \
 && npm run deploy --- -m

#ENTRYPOINT ["/bin/bash", "-c"]
