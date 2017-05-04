FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"
RUN sudo apt-get update && \
    sudo apt-get install -y ros-${ROSVERSION}-care-o-bot && \
    sudo apt-get clean && \
    sudo apt-get autoremove && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ROBOT cob4-2
ENV ROBOT_ENV=ipa-apartment
