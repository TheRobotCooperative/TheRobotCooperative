FROM ros:melodic

RUN echo "installing vnc prerequisites..." \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
      bzip2 \
      ca-certificates \
      curl \
      tmux \
      vim \
      wget

# install vnc4server
RUN apt-get install -y --no-install-recommends vnc4server

## install a desktop environment
RUN echo "installing desktop environment: Xfce 4..." \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y \
      supervisor \
      xfce4 \
      xfce4-goodies \
      xfce4-terminal \
      xterm \
      xserver-xorg-core \
      xvfb \
      x11vnc

# create the xstartup file
RUN mkdir ~/.vnc \
 && echo "#!/bin/bash\n\
# disable screensaver and power management\n\
set -e\n\
xset -dpms\n\
xset s noblank\n\ 
xset s off\n\
exec startxfce4 &\n\
 " >> ~/.vnc/xstartup \
 && chmod 755 ~/.vnc/xstartup \
 && /bin/bash -c "echo -e 'password\npassword\nn' | vncpasswd"

### install a standalone tigervnc
#ARG TIGERVNC_URL="https://bintray.com/tigervnc/stable/download_file?file_path=tigervnc-1.10.1.x86_64.tar.gz"
#ENV TIGERVNC_DIR /opt/tigervnc
#RUN echo "installing tigervnc..." \
# && mkdir -p "${TIGERVNC_DIR}" \
# && curl -L -s "${TIGERVNC_URL}" | tar xvz --strip-components=1 -C "${TIGERVNC_DIR}"
#ENV PATH "${TIGERVNC_DIR}/usr/bin:${PATH}"

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/bin/bash"]

RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list \
 && wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - \
 && apt-get update \
 && apt-get install -y gazebo11
