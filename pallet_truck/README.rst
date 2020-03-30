pallet_truck
============

Status
------

There is a build order issue somewhere in the code that causes catkin to
attempt to build :code:`pallet_truck_common/ackermann_drive_controller` before
:code:`robotnik_msgs` has been built. Attempting to build the code again after
the initial failure will work (as the :code:`robotnik_msgs` headers will have
been generated and will be present in :code:`/ros_ws/devel/include`).

In a bizzare twist, the build issue only occurs if :code:`catkin_make` is used
but not if :code:`catkin build` is used.

.. code::

   In file included from /ros_ws/src/pallet_truck/pallet_truck_common/ackermann_drive_controller/src/ackermann_drive_controller.cpp:7:0:
   /ros_ws/src/pallet_truck/pallet_truck_common/ackermann_drive_controller/include/ackermann_drive_controller/ackermann_drive_controller.h:21:36: fatal error: robotnik_msgs/set_mode.h: No such file or directory
   compilation terminated.


References
----------

* https://github.com/RobotnikAutomation/pallet_truck
