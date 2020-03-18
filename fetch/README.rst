Fetch
=====

.. image:: robot.jpg

Meshes and URDF files can be found at: /ros_ws/src/fetch_ros/fetch_description

https://bitbucket.org/osrf/gzweb/issues/45/creating-local-model-of
https://bitbucket.org/iche033/turtlebot_race/src/default/setup.sh


Structure
---------

The models directory, added to `GAZEBO_MODEL_PATH`, should contain several
directories. Each of these directories provides a single model and should
contain a `model.config` file. (See https://bitbucket.org/iche033/turtlebot_race/src/default/gazebo_models/turtlebot_description/model.config)


.. code:: xml

   <?xml version="1.0">
   <model>
      <name>fetch</name>
      <version>1.0</version>
      <sdf version="1.4">robots/fetch.urdf</sdf>
   </model>


Alternatively, use dynamic conversion: (slow?)
https://bitbucket.org/osrf/gzweb/issues/45/creating-local-model-of


https://github.com/ros-simulation/gazebo_ros_pkgs/pull/288
https://github.com/ros-simulation/gazebo_ros_pkgs/issues/449
