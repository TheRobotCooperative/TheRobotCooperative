FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"
RUN sudo apt-get update && \
    sudo apt-get install -y ros-${ROSVERSION}-nao-robot \
                            ros-${ROSVERSION}-nao-extras && \
    sudo apt-get clean && \
    sudo apt-get autoremove && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
