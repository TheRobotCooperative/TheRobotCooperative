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
intend to include these steps in the general :code:`Dockerfile` used for each robot.
(If anyone wants to take a shot at automating the process and adding the steps
to :code:`Dockerfile`, that would also be awesome.)

1. First, you need to convert any robot description files from Xacro into pure
   URDF. Typically, Xacro files end in :code:`.urdf.xacro` or :code:`.xacro.urdf`, but be
   aware that sometimes Xacro files will simply end in `.urdf`, making it
   impossible to distinguish them from pure URDF on the sole basis of their
   file ending.
   The following code can be executed from within a catkin workspace to
   transform an Xacro file, :code:`model.urdf.xacro`, into a pure URDF file,
   :code:`model.urdf`:

   .. code::

      $ rosrun xacro xacro --inorder model.urdf.xacro > model.urdf

   It should be fine to run this file on a pure URDF file: in that case, you
   will receive a semantically equivalent URDF file with slightly different
   formatting.

2. Next, you must replace all instances of :code:`package://` inside your pure URDF
   files with :code:`model://`. This can be done by executing the following code on
   a pure URDF file:

   .. code::

      $ sed -i "s#package://#model://#g" model.urdf

3. To enable gzweb compatibility, you must add a :code:`model.config` for each
   model that you wish to visualise in simulation. Below is an example of a
   :code:`model.config` file, taken from a repository that has gzweb support
   (https://bitbucket.org/iche033/turtlebot_race/src/default/gazebo_models/turtlebot_description/model.config):

   .. code:: xml

      <?xml version="1.0"?>
      <model>
        <name>turtlebot</name>
        <version>1.0</version>
        <sdf version="1.4">kobuki_hexagons_kinect.urdf</sdf>

        <author>
          <name>osrf</name>
          <email>osrf@osrfoundation.org</email>
        </author>

        <author>
          <name>Nate Koenig</name>
          <email>natekoenig@gmail.com</email>
        </author>

        <description>Kobuki robot</description>
      </model>

   At the time of writing, my understanding of :code:`model.config` files is
   that either:

   1. There must be a single :code:`model.config` file at the root of the
      package responsible for providing a description of that robot that
      you wish to simulate (e.g., :code:`turtlebot_description`).
   2. The package may provide multiple model description files in the same
      manner that the central `gazebo_models <https://bitbucket.org/osrf/gazebo_models>`_
      repository does so by creating a separate top-level directory for each
      robot provided by that package (e.g., :code:`turtlebot`) and placing
      a separate :code:`model.config` in each of these top-level directories
      (e.g., :code:`turtlebot/model.config`).

4. To essentially "register" your model with Gazebo and GzWeb, you must add
   each of the ROS package directories within your workspace that provide
   models to the :code:`GAZEBO_MODEL_PATH` environment variable using the absolute
   paths of those directories.

   For example, to register the models for the Fetch robot, we update the
   :code:`GAZEBO_MODEL_PATH` as follows:

   .. code::

      $ export GAZEBO_MODEL_PATH="/ros_ws/src/fetch_ros/fetch_description:${GAZEBO_MODEL_PATH}"

   (For the purposes of automation, it may be possible to discover these
   directories using some simple bash scripting. It also appears that there
   is no serious disadvantage to simply adding the path of every ROS package
   to :code:`GAZEBO_MODEL_PATH`; a slightly higher upfront cost is paid when
   initially deploying models via :code:`deploy.sh`, but that should be the only
   difference.)

5. Finally, you must use :code:`/opt/gazebo/deploy.sh` to collect the local
   models from your catkin workspace by searching each directory in the
   :code:`GAZEBO_MODEL_PATH` environment variable:

   .. code::

      $ /opt/gzweb/deploy.sh -m local

   At the end of this process, you should *hopefully* see your local models
   appear in :code:`/opt/gzweb/http/client/assets`. If your models don't appear
   in that directory, then they won't be rendered by gzweb.


Notes
-----

Below are the contents of an XML launch file,
:code:`turtlebot/turtlebot_simulator/melodic/turtlebot_gazebo/launch/includes/kobuki.launch.xml`,
for spawning a TurtleBot in simulation:

.. code:: xml

  <launch>
    <arg name="base"/>
    <arg name="stacks"/>
    <arg name="3d_sensor"/>

    <arg name="urdf_file" default="$(find xacro)/xacro '$(find turtlebot_description)/robots/$(arg base)_$(arg stacks)_$(arg 3d_sensor).urdf.xacro'"/>
    <param name="robot_description" command="$(arg urdf_file)"/>

    <!-- Gazebo model spawner -->
    <node name="spawn_turtlebot_model" pkg="gazebo_ros" type="spawn_model"
          args="$(optenv ROBOT_INITIAL_POSE) -unpause -urdf -param robot_description -model mobile_base"/>

    <!-- Velocity muxer -->
    <node pkg="nodelet" type="nodelet" name="mobile_base_nodelet_manager" args="manager"/>
    <node pkg="nodelet" type="nodelet" name="cmd_vel_mux"
          args="load yocs_cmd_vel_mux/CmdVelMuxNodelet mobile_base_nodelet_manager">
      <param name="yaml_cfg_file" value="$(find turtlebot_bringup)/param/mux.yaml"/>
      <remap from="cmd_vel_mux/output" to="mobile_base/commands/velocity"/>
    </node>

    <!-- Bumper/cliff to pointcloud (not working, as it needs sensors/core messages) -->
    <include file="$(find turtlebot_bringup)/launch/includes/kobuki/bumper2pc.launch.xml"/>
  </launch>


Notice that the :code:`.xacro` file is converted into a URDF and stored in the
value of the :code:`urdf_file` arg. The value of that argument is saved to the
:code:`robot_description` parameter, which is subsequently pushed to the ROS
Parameter server.
Finally, the :code:`spawn_turtlebot_model` node accepts the name of a URDF file
via its :code:`-param` option.


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
