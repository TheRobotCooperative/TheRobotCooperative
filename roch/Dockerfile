FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROS_DISTRO "indigo"

# create "robot" user with passwordless sudo
RUN useradd -ms /bin/bash robot && \
    usermod -a -G sudo robot && \
    sed -i "s/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/" "/etc/sudoers" && \
    mkdir -p /home/robot/catkin_ws/src && \
    chown -R robot:robot /home/robot
USER robot
WORKDIR /home/robot/catkin_ws

RUN cd ~/catkin_ws/src && \
    git clone http://github.com/SawYer-Robotics/roch.git && \
    git clone http://github.com/SawYer-Robotics/roch_robot.git && \
    git clone http://github.com/SawYer-Robotics/roch_simulator.git && \
    git clone http://github.com/SawYer-Robotics/roch_viz.git
RUN sudo apt-get update
RUN rosdep update -y
RUN rosdep install --from-paths src --ignore-src --rosdistro indigo -y
RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash / && catkin_make install -j $(nproc)"
