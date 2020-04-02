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
      xserver-xorg-core

# create the xstartup file
RUN mkdir ~/.vnc \
 && echo "#!/bin/bash \
# disable screensaver and power management \
set -e \
xset -dpms \
xset s noblank \ 
xset s off \
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
