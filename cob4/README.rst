Care-o-Bot 4
============

To launch the robot in a Gazebo simulation, use :code:`roslaunch` on the following launchfile:

::

  $ roslaunch /ros_ws/src/cob_simulation/cob_gazebo/launch/robot.launch \
      robot:=cob4-9 \
      robot_env:=ipa-apartment


To launch the GazeboWeb server:

::

  $ cd /opt/gzweb && npm start


References
----------

https://answers.ros.org/question/227638/costmap2dros-transform-timeoutcould-not-get-robot-pose-cancelling-reconfiguration
