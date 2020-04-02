URDF
====

This memo briefly describes how URDF/Xacro files are parsed and how their
corresponding robots are spawned in simulation.

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
