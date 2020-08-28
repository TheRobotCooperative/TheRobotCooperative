#!/bin/bash
set -x
wget https://repo1.maven.org/maven2/ant/optional/1.5.4/optional-1.5.4.jar 
mv optional-1.5.4.jar /usr/share/ant/lib
git clone https://git.code.sf.net/p/plexil/git /root/plexil
export PLEXIL_HOME=/root/plexil
export PATH="${PATH}:${PLEXIL_HOME}/scripts"
if [ -z "$LD_LIBRARY_PATH" ]
then
    export LD_LIBRARY_PATH="$_plexil_libpath"
else
    export LD_LIBRARY_PATH="$_plexil_libpath:$LD_LIBRARY_PATH"
fi
echo 'export PLEXIL_HOME=/root/plexil' >> ~/.bashrc
echo 'source $PLEXIL_HOME/scripts/plexil-setup.sh' >> ~/.bashrc
# This is called by Docker, which uses sh not bash
echo 'export PLEXIL_HOME=/root/plexil' >> ~/.profile
echo '. $PLEXIL_HOME/scripts/plexil-setup.sh' >> ~/.profile
. ~/.profile  
#source ~/.bashrc
echo "PLEXIL_HOME=\"${PLEXIL_HOME}\""
cd /root/plexil
make src/configure
cd src
./configure CFLAGS="-g -O2" CXXFLAGS="-g -O2" --prefix=/root/plexil --disable-static --disable-viewer --enable-ipc
cd /root/plexil
make
