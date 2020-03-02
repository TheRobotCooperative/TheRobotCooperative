FROM ros:indigo
MAINTAINER Chris Timperley "christimperley@gmail.com"

ENV ROSVERSION "indigo"
RUN apt-get update && \
    apt-get --no-install-recommends install -y ros-${ROSVERSION}-grizzly-desktop \
                            ros-${ROSVERSION}-grizzly-navigation \
                            ros-${ROSVERSION}-grizzly-simulator && \
    apt-get clean && \
    apt-get autoremove && \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base
