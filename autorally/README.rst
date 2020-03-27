AutoRally
=========

.. image:: robot.jpg


Status
------

.. code::

   [100%] Linking CXX executable /ros_ws/devel/lib/autorally_core/StateEstimator
   /usr/bin/ld: cannot find -lBoost::serialization
   /usr/bin/ld: cannot find -lBoost::system
   /usr/bin/ld: cannot find -lBoost::filesystem
   /usr/bin/ld: cannot find -lBoost::thread
   /usr/bin/ld: cannot find -lBoost::date_time
   /usr/bin/ld: cannot find -lBoost::regex
   /usr/bin/ld: cannot find -lBoost::timer
   /usr/bin/ld: cannot find -lBoost::chrono
   collect2: error: ld returned 1 exit status
   make[2]: *** [/ros_ws/devel/lib/autorally_core/StateEstimator] Error 1
   autorally/autorally_core/src/StateEstimator/CMakeFiles/StateEstimator.dir/build.make:140: recipe for target '/ros_ws/devel/lib/autorally_core/StateEstimator' failed
   CMakeFiles/Makefile2:7472: recipe for target 'autorally/autorally_core/src/StateEstimator/CMakeFiles/StateEstimator.dir/all' failed
   make[1]: *** [autorally/autorally_core/src/StateEstimator/CMakeFiles/StateEstimator.dir/all] Error 2


References
----------

* https://github.com/AutoRally
* https://github.com/AutoRally/autorally/issues/84
* https://github.com/ethz-asl/rotors_simulator/issues/520
* http://wiki.ros.org/catkin/CMakeLists.txt
