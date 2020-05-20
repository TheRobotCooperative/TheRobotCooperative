!#/bin/bash

# installing range_libc
pip install cython==0.29.17
cd /ros_ws/src/range_libc/pywrapper && python setup.py install

# copying the racetrack model otherwise Gazebo won't find it
mkdir /root/.gazebo
mkdir /root/.gazebo/models
cp -r /ros_ws/src/simulator/world/race_track /root/.gazebo/models/
