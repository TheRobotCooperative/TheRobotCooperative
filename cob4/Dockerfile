FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"
RUN apt-get update && \
    apt-get --no-install-recommends install -y ros-${ROSVERSION}-care-o-bot && \
    apt-get clean && \
    apt-get autoremove && \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

ENV ROBOT cob4-2
ENV ROBOT_ENV=ipa-apartment
