# Originally built for ROS Hydro, but supports ROS Indigo
FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROBOT_NAME ridgeback
ENV ROSVERSION "indigo"

# create "robot" user with passwordless sudo
RUN useradd -ms /bin/bash robot && \
    usermod -a -G sudo robot && \
    sed -i "s/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/" "/etc/sudoers" && \
    mkdir -p "/home/robot/${ROBOT_NAME}"
USER robot
WORKDIR "/home/robot/${ROBOT_NAME}"

# add ROS install file
ADD rosinstall rosinstall
RUN sudo rosinstall src /opt/ros/indigo rosinstall && \
    sudo apt-get update && \
    rosdep update && \
    rosdep install  -y \
                    --from-paths src \
                    --ignore-src \
                    --rosdistro indigo
# RUN sudo apt-get install -y python-catkin-tools
# RUN sudo bash -c "source src/setup.sh && catkin build -j $(nproc)"
