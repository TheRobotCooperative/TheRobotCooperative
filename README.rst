Robots.Dockerfile
=================

A collection of Dockerfiles for various different ROS robots

* Kobuki
* Grizzly
* Autoware
* Jackal
* TurtleBot **(needs to be ported)**
* Care-O-Bot 4
* Fetch
* Freight
* [Roch](http://wiki.ros.org/Robots/Roch)
* [Aldebaran Nao](http://wiki.ros.org/nao)


Installation
------------

To use GzWeb, you must ensure that all of the required Gazebo models that will
be simulated have been baked into `http/client/assets`:

.. code::

  $ export GAZEBO_MODEL_PATH="foo"
  $ cd /opt/gzweb
  $ npm run deploy --- -m


Usage
-----

Todo


Resources
---------

http://moore-mike.com/docker-ros.html
http://gazebosim.org/tutorials?tut=gzweb_install&cat=gzweb
https://github.com/nodejs/help/wiki/Installation
https://answers.gazebosim.org//question/17367/simulated-robot-model-randomly-appears-in-gzweb-gui/
