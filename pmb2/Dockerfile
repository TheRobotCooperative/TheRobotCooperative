# Originally built for ROS Hydro, but supports ROS Indigo
FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"

# create "robot" user with passwordless sudo
RUN useradd -ms /bin/bash robot && \
    usermod -a -G sudo robot && \
    sed -i "s/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/" "/etc/sudoers"
USER robot

# add ROS install file
ADD pmb2_public.rosinstall "${HOME}/pmb2/pmb2_public.rosinstall"

RUN mkdir ~/pmb2 && \
    cd ~/pmb2 && \
    
#RUN sudo apt-get update && \
#    sudo apt-get install -y ros-${ROSVERSION}-grizzly-desktop \
#                            ros-${ROSVERSION}-grizzly-navigation \
#                            ros-${ROSVERSION}-grizzly-simulator && \
#    sudo apt-get clean && \
#    sudo apt-get autoremove && \
#    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
