# Originally built for ROS Hydro, but supports ROS Indigo
FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"

# create "robot" user with passwordless sudo
RUN useradd -ms /bin/bash robot && \
    usermod -a -G sudo robot && \
    sed -i "s/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/" "/etc/sudoers" && \
    mkdir -p /home/robot/pmb2
USER robot
WORKDIR /home/robot/pmb2

# add ROS install file
ADD pmb2_public.rosinstall pmb2.rosinstall
RUN sudo rosinstall src /opt/ros/indigo pmb2.rosinstall && \
    sudo apt-get update && \
    rosdep update && \
    rosdep install  -y \
                    --from-paths src \
                    --ignore-src \
                    --rosdistro indigo \
                    --skip-keys \
                    "pal_gazebo_plugins speed_limit sensor_to_cloud"
RUN sudo apt-get install -y python-catkin-tools
RUN sudo bash -c "source src/setup.sh && catkin build -j $(nproc)"

#RUN sudo apt-get update && sudo apt-get install -y ros-indigo-joint-state-controller
