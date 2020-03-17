Robots.Dockerfile
=================

A collection of Dockerfiles for a variety of ROS robot platforms and
applications, built with support for web-based visualisation via GzWeb.


Installation
------------

To use GzWeb, you must ensure that all of the required Gazebo models that will
be simulated have been baked into `http/client/assets`:

.. code::

  $ export GAZEBO_MODEL_PATH="foo"
  $ cd /opt/gzweb
  $ npm run deploy --- -m


Resources
---------

* https://github.com/Ly0n/awesome-robotic-tooling
* http://moore-mike.com/docker-ros.html
* http://gazebosim.org/tutorials?tut=gzweb_install&cat=gzweb
* https://github.com/nodejs/help/wiki/Installation
* https://answers.gazebosim.org//question/17367/simulated-robot-model-randomly-appears-in-gzweb-gui/
* https://github.com/ros-simulation/gazebo_ros_pkgs/pull/288
* https://bitbucket.org/osrf/gzweb/issues/45/creating-local-model-of
* https://bitbucket.org/iche033/turtlebot_race/src/default/gazebo_models/turtlebot_description/
