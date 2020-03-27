AutoRally
=========

.. image:: robot.jpg


Status
------

This build error makes no sense. The missing header file actually exists
at :code:`/ros_ws/devel/include/imu_3dm_gx4/FilterOutput.h`. Why isn't
the compiler picking up on this?

.. code::

   Errors     << autorally_core:make /ros_ws/logs/autorally_core/build.make.000.log                                                                                                   
   /ros_ws/src/autorally/autorally_core/src/ocs/ImageMaskEntry.hpp:0: Note: No relevant classes found. No output generated.
   /ros_ws/src/autorally/autorally_core/src/CameraAutoBalance/CameraAutoBalance.cpp: In member function ‘void autorally_core::CameraAutoBalance::configCallback(const autorally_core::camera_auto_balance_paramsConfig&, uint32_t)’:
   /ros_ws/src/autorally/autorally_core/src/CameraAutoBalance/CameraAutoBalance.cpp:86:97: warning: unused parameter ‘level’ [-Wunused-parameter]
    void CameraAutoBalance::configCallback(const camera_auto_balance_paramsConfig &config, uint32_t level)
                                                                                                    ^~~~~
   In file included from /ros_ws/src/autorally/autorally_core/src/StateEstimator/StateEstimator.cpp:52:0:
   /ros_ws/src/autorally/autorally_core/src/StateEstimator/StateEstimator.h:68:10: fatal error: imu_3dm_gx4/FilterOutput.h: No such file or directory
    #include <imu_3dm_gx4/FilterOutput.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [src/StateEstimator/CMakeFiles/StateEstimator.dir/StateEstimator.cpp.o] Error 1
   make[1]: *** [src/StateEstimator/CMakeFiles/StateEstimator.dir/all] Error 2
   make[1]: *** Waiting for unfinished jobs....
   make: *** [all] Error 2
   cd /ros_ws/build/autorally_core; c


References
----------

* https://github.com/AutoRally
* https://github.com/AutoRally/autorally/issues/84
* https://github.com/ethz-asl/rotors_simulator/issues/520
