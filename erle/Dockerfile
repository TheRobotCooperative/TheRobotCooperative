# http://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html#setting-up-sitl-on-linux
FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"

# create "robot" user with passwordless sudo
RUN useradd -ms /bin/bash robot && \
    usermod -a -G sudo robot && \
    sed -i "s/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/" "/etc/sudoers" && \
    mkdir -p /home/robot
USER robot
WORKDIR /home/robot

RUN git clone https://github.com/ArduPilot/ardupilot
RUN cd ardupilot && git submodule update --init --recursive

# install build tools
RUN sudo apt-get update && \
    sudo apt-get install -y libtool \
                            automake \
                            autoconf \
                            gcc \
                            g++ \
                            libexpat1-dev

RUN git clone git://github.com/tridge/jsbsim
RUN cd jsbsim && \
    ./autogen.sh --enable-libraries && \
    make -j

RUN sudo apt-get install -y python-matplotlib \
                            python-serial \
                            python-wxgtk2.8 \
                            python-wxtools \
                            python-lxml \
                            python-scipy \
                            python-opencv \
                            ccache \
                            gawk \
                            python-pip \
                            python-pexpect
RUN sudo pip install future pymavlink MAVProxy

ENV HOME "/home/robot"
ENV PATH "${PATH}:${HOME}/jsbsim/src"
ENV PATH "${PATH}:${HOME}/ardupilot/Tools/autotest"
ENV PATH "${PATH}:/usr/lib/ccache:${PATH}"
