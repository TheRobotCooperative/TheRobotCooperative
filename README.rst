Robots.Dockerfile
=================

A collection of Dockerfiles for a variety of ROS robot platforms and
applications, built with support for web-based visualisation via GzWeb.


Installation
------------

GzWeb
.....

To use GzWeb, you must ensure that all of the required Gazebo models that will
be simulated have been baked into `http/client/assets`.
The required Gazebo models may come from both the remote
`gazebo_models <https://bitbucket.org/osrf/gazebo_models>`_ repository,
as well as from local sources inside your catkin workspace.
The remote database of models is installed by passing the `-m` option to
`/opt/gzweb/deploy.sh` as follows:

.. code::

  $ /opt/gzweb/deploy.sh -m

Installing models from local sources is trickier and is not as well documented.
Below is a rough description of the steps that one generally needs to take to
add gzweb compatibility to a particular ROS package. In the very near future, I
intend to include these steps in the general `Dockerfile` used for each robot.
(If anyone wants to take a shot at automating the process and adding the steps
to `Dockerfile`, that would also be awesome.)

1. First, you need to convert any robot description files from Xacro into pure
   URDF. Typically, Xacro files end in `.urdf.xacro` or `.xacro.urdf`, but be
   aware that sometimes Xacro files will simply end in `.urdf`, making it
   impossible to distinguish them from pure URDF on the sole basis of their
   file ending.
   The following code can be executed from within a catkin workspace to
   transform an Xacro file, `model.urdf.xacro`, into a pure URDF file,
   `model.urdf`:

   .. code::

      $ rosrun xacro xacro --inorder model.urdf.xacro > model.urdf

   It should be fine to run this file on a pure URDF file: in that case, you
   will receive a semantically equivalent URDF file with slightly different
   formatting.

2. Next, you must replace all instances of `package://` inside your pure URDF
   files with `model://`. This can be done by executing the following code on
   a pure URDF file:

   .. code::
      
      $ sed -i "s#package://#model://#g" model.urdf

3. To essentially "register" your model with Gazebo, you must add 
   each of the ROS package directories within your workspace that provide
   models to the `GAZEBO_MODEL_PATH` environment variable using the absolute
   paths of those directories.

   For example, to register the models for the Fetch robot, we update the
   `GAZEBO_MODEL_PATH` as follows:

   .. code::

      $ export GAZEBO_MODEL_PATH="/ros_ws/src/fetch_ros/fetch_description:${GAZEBO_MODEL_PATH}"

   (For the purposes of automation, it may be possible to discover these
   directories using some simple bash scripting. It also appears that there
   is no serious disadvantage to simply adding the path of every ROS package
   to `GAZEBO_MODEL_PATH`; a slightly higher upfront cost is paid when
   initially deploying models via `deploy.sh`, but that should be the only
   difference.)
   
4. Add model.config for each model
5. Deploy: ./deploy -m local


Resources
---------

* https://answers.ros.org/question/10401/how-to-convert-xacro-file-to-urdf-file
* https://github.com/Ly0n/awesome-robotic-tooling
* http://moore-mike.com/docker-ros.html
* http://gazebosim.org/tutorials?tut=gzweb_install&cat=gzweb
* https://github.com/nodejs/help/wiki/Installation
* https://answers.gazebosim.org//question/17367/simulated-robot-model-randomly-appears-in-gzweb-gui/
* https://github.com/ros-simulation/gazebo_ros_pkgs/pull/288
* https://bitbucket.org/osrf/gzweb/issues/45/creating-local-model-of
* https://bitbucket.org/iche033/turtlebot_race/src/default/gazebo_models/turtlebot_description/
