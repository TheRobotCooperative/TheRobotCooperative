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
# supervisor
FROM ros:${DISTRO} AS main
WORKDIR /ros_ws
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      apt-utils \
      bzip2 \
      ca-certificates \
      curl \
      gcc \
      g++ \
      python-pip \
      "ros-${ROS_DISTRO}-cmake-modules" \
      software-properties-common \
      tmux \
      vim \
      wget \
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

# install vncserver
#
# References:
# http://blog.fx.lv/2017/08/running-gui-apps-in-docker-containers-using-vnc
# https://qxf2.com/blog/view-docker-container-display-using-vnc-viewer
# https://github.com/ConSol/docker-headless-vnc-container/blob/master/src/ubuntu/install/libnss_wrapper.sh
# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-18-04
# https://hackernoon.com/installation-of-vnc-server-on-ubuntu-1cf035370bd3
# https://www.tecmint.com/install-and-configure-vnc-server-on-ubuntu
# https://stackoverflow.com/questions/48601146/docker-how-to-set-tightvncserver-password
RUN apt-get update \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
      supervisor \
      vnc4server \
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
 && echo "#!/bin/bash\n\
# disable screensaver and power management\n\
set -e\n\
xset -dpms\n\
xset s noblank\n\
xset s off\n\
exec startxfce4\n\
 " >> ~/.vnc/xstartup \
 && chmod 755 ~/.vnc/xstartup \
 && /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini
COPY rootfs /

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
     && (echo "running prebuild step..." && /bin/bash /.dockerinstall/prebuild.sh || exit 1) \
     || (echo "skipping prebuild step [no prebuild.sh]" && exit 0)) \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ARG BUILD_COMMAND="catkin_make"
RUN . /opt/ros/${ROS_DISTRO}/setup.sh \
 && eval "${BUILD_COMMAND}"

# install gazebo models
COPY --from=gzweb /opt/gzweb /opt/gzweb
RUN cd /opt/gzweb \
 && . /usr/share/gazebo/setup.sh \
 && npm run deploy --- -m
RUN (test -f /.dockerinstall/postbuild.sh \
     && (echo "running postbuild step..." && /.dockerinstall/postbuild.sh || exit 1) \
     || (echo "skipping postbuild step [no postbuild.sh]" && exit 0))
