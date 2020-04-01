Fetch
=====

.. image:: robot.jpg


Progress
--------

.. image:: gzweb-progress.png


Usage
-----

To launch the Fetch robot in a simulated office:

.. code::

   # roslaunch fetch_gazebo playground.launch


As usual, GzWeb is started via:

.. code::

   # cd /opt/gzweb && npm start


Be aware that :code:`gzweb` may seg. fault for no apparent reason on the first
attempt to launch. Subsequent attempts seem to work fine? (Potential flakiness.)

Once the robot has been spawned in the simulated world, a demo application can
be started by executing the following:

.. code::

   # roslaunch fetch_gazebo_demo demo.launch


Notes
-----

.. code:: command

   root@3e359887b8ae:/ros_ws# rostopic list
   /arm_controller/follow_joint_trajectory/cancel
   /arm_controller/follow_joint_trajectory/feedback
   /arm_controller/follow_joint_trajectory/goal
   /arm_controller/follow_joint_trajectory/result
   /arm_controller/follow_joint_trajectory/status
   /arm_with_torso_controller/follow_joint_trajectory/cancel
   /arm_with_torso_controller/follow_joint_trajectory/feedback
   /arm_with_torso_controller/follow_joint_trajectory/goal
   /arm_with_torso_controller/follow_joint_trajectory/result
   /arm_with_torso_controller/follow_joint_trajectory/status
   /base_controller/command
   /base_scan
   /base_scan_raw
   /clock
   /cmd_vel
   /cmd_vel_mux/selected
   /gazebo/bellows_joint/position/parameter_descriptions
   /gazebo/bellows_joint/position/parameter_updates
   /gazebo/bellows_joint/velocity/parameter_descriptions
   /gazebo/bellows_joint/velocity/parameter_updates
   /gazebo/elbow_flex_joint/position/parameter_descriptions
   /gazebo/elbow_flex_joint/position/parameter_updates
   /gazebo/elbow_flex_joint/velocity/parameter_descriptions
   /gazebo/elbow_flex_joint/velocity/parameter_updates
   /gazebo/forearm_roll_joint/position/parameter_descriptions
   /gazebo/forearm_roll_joint/position/parameter_updates
   /gazebo/forearm_roll_joint/velocity/parameter_descriptions
   /gazebo/forearm_roll_joint/velocity/parameter_updates
   /gazebo/head_pan_joint/position/parameter_descriptions
   /gazebo/head_pan_joint/position/parameter_updates
   /gazebo/head_pan_joint/velocity/parameter_descriptions
   /gazebo/head_pan_joint/velocity/parameter_updates
   /gazebo/head_tilt_joint/position/parameter_descriptions
   /gazebo/head_tilt_joint/position/parameter_updates
   /gazebo/head_tilt_joint/velocity/parameter_descriptions
   /gazebo/head_tilt_joint/velocity/parameter_updates
   /gazebo/l_gripper_finger_joint/position/parameter_descriptions
   /gazebo/l_gripper_finger_joint/position/parameter_updates
   /gazebo/l_gripper_finger_joint/velocity/parameter_descriptions
   /gazebo/l_gripper_finger_joint/velocity/parameter_updates
   /gazebo/l_wheel_joint/position/parameter_descriptions
   /gazebo/l_wheel_joint/position/parameter_updates
   /gazebo/l_wheel_joint/velocity/parameter_descriptions
   /gazebo/l_wheel_joint/velocity/parameter_updates
   /gazebo/link_states
   /gazebo/model_states
   /gazebo/parameter_descriptions
   /gazebo/parameter_updates
   /gazebo/r_gripper_finger_joint/position/parameter_descriptions
   /gazebo/r_gripper_finger_joint/position/parameter_updates
   /gazebo/r_gripper_finger_joint/velocity/parameter_descriptions
   /gazebo/r_gripper_finger_joint/velocity/parameter_updates
   /gazebo/r_wheel_joint/position/parameter_descriptions
   /gazebo/r_wheel_joint/position/parameter_updates
   /gazebo/r_wheel_joint/velocity/parameter_descriptions
   /gazebo/r_wheel_joint/velocity/parameter_updates
   /gazebo/set_link_state
   /gazebo/set_model_state
   /gazebo/shoulder_lift_joint/position/parameter_descriptions
   /gazebo/shoulder_lift_joint/position/parameter_updates
   /gazebo/shoulder_lift_joint/velocity/parameter_descriptions
   /gazebo/shoulder_lift_joint/velocity/parameter_updates
   /gazebo/shoulder_pan_joint/position/parameter_descriptions
   /gazebo/shoulder_pan_joint/position/parameter_updates
   /gazebo/shoulder_pan_joint/velocity/parameter_descriptions
   /gazebo/shoulder_pan_joint/velocity/parameter_updates
   /gazebo/torso_lift_joint/position/parameter_descriptions
   /gazebo/torso_lift_joint/position/parameter_updates
   /gazebo/torso_lift_joint/velocity/parameter_descriptions
   /gazebo/torso_lift_joint/velocity/parameter_updates
   /gazebo/upperarm_roll_joint/position/parameter_descriptions
   /gazebo/upperarm_roll_joint/position/parameter_updates
   /gazebo/upperarm_roll_joint/velocity/parameter_descriptions
   /gazebo/upperarm_roll_joint/velocity/parameter_updates
   /gazebo/wrist_flex_joint/position/parameter_descriptions
   /gazebo/wrist_flex_joint/position/parameter_updates
   /gazebo/wrist_flex_joint/velocity/parameter_descriptions
   /gazebo/wrist_flex_joint/velocity/parameter_updates
   /gazebo/wrist_roll_joint/position/parameter_descriptions
   /gazebo/wrist_roll_joint/position/parameter_updates
   /gazebo/wrist_roll_joint/velocity/parameter_descriptions
   /gazebo/wrist_roll_joint/velocity/parameter_updates
   /gripper_controller/gripper_action/cancel
   /gripper_controller/gripper_action/feedback
   /gripper_controller/gripper_action/goal
   /gripper_controller/gripper_action/result
   /gripper_controller/gripper_action/status
   /head_camera/crop_decimate/parameter_descriptions
   /head_camera/crop_decimate/parameter_updates
   /head_camera/depth_downsample/camera_info
   /head_camera/depth_downsample/image_raw
   /head_camera/depth_downsample/points
   /head_camera/head_camera_nodelet_manager/bond
   /head_controller/follow_joint_trajectory/cancel
   /head_controller/follow_joint_trajectory/feedback
   /head_controller/follow_joint_trajectory/goal
   /head_controller/follow_joint_trajectory/result
   /head_controller/follow_joint_trajectory/status
   /head_controller/point_head/cancel
   /head_controller/point_head/feedback
   /head_controller/point_head/goal
   /head_controller/point_head/result
   /head_controller/point_head/status
   /joint_states
   /odom
   /query_controller_states/cancel
   /query_controller_states/feedback
   /query_controller_states/goal
   /query_controller_states/result
   /query_controller_states/status
   /rosout
   /rosout_agg
   /teleop/cmd_vel
   /tf
   /tf_static
   /torso_controller/follow_joint_trajectory/cancel
   /torso_controller/follow_joint_trajectory/feedback
   /torso_controller/follow_joint_trajectory/goal
   /torso_controller/follow_joint_trajectory/result
   /torso_controller/follow_joint_trajectory/status


Issues
------

The robot will refuse to move unless all `model` references are removed from
the URDF file. As a temporary workaround, those file references can be replaced
with absolute paths via the following command:

.. code::

   # sed -i "s#model://#/ros_ws/src/fetch_gazebo/fetch_gazebo/robots/#g" /ros_ws/src/fetch_gazebo/fetch_gazebo/robots/fetch/fetch.gazebo.urdf
