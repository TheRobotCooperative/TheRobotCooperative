ARG DISTRO

FROM ubuntu:18.04 AS gzweb
ENV GZWEB_RELEASE gzweb_1.4.0
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      mercurial \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && hg clone https://bitbucket.org/osrf/gzweb /opt/gzweb -u "${GZWEB_RELEASE}"

# NOTE: We need to install the cmake_modules to avoid some build failures
# that are due to unspecified dependencies.
# (https://github.com/ros-industrial/industrial_calibration/issues/50)
FROM ros:${DISTRO} AS main
WORKDIR /ros_ws
RUN apt-get update \
 && apt-get install -y --no-install-recommends --allow-unauthenticated \
      apt-utils \
      ca-certificates \
      "ros-${ROS_DISTRO}-cmake-modules" \
      vim \
      software-properties-common \
      wget \
      curl \
      g++ \
      gcc \
      python-pip \
      tmux \
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

# install gzweb deps
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      wget \
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
ARG DIRECTORY
COPY "${DIRECTORY}" /.dockerinstall
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
 && (test -f /.dockerinstall/prebuild.sh \
     && /bin/bash /.dockerinstall/prebuild.sh \
     || exit 0) \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
 && catkin build

# install gazebo models
COPY --from=gzweb /opt/gzweb /opt/gzweb
RUN cd /opt/gzweb \
 && . /usr/share/gazebo/setup.sh \
 && npm run deploy --- -m
RUN (test -f /.dockerinstall/postbuild.sh \
     && (echo "running postbuild script..." && /.dockerinstall/postbuild.sh || exit 1) \
     || (echo "skipping postbuild step [no postbuild.sh]" && exit 0))

EXPOSE 8080
EXPOSE 7681
