Fetch
=====

.. image:: robot.jpg


Progress
--------

.. image:: gzweb-progress.png


Usage
-----

To ensure that the camera works correctly during headless execution, we must
use Xvfb to create a virtual X server, as shown below. Failing to do so will
lead to a camera that silently does nothing.

.. code:: command

   $ Xvfb :1 -screen 0 1600x1200x16  &
   $ export DISPLAY=:1.0

To launch the Fetch robot in a simulated office:

.. code:: command

   $ roslaunch fetch_gazebo playground.launch


As usual, GzWeb is started via:

.. code:: command

   $ cd /opt/gzweb && npm start


Be aware that :code:`gzweb` may seg. fault for no apparent reason on the first
attempt to launch. Subsequent attempts seem to work fine? (Potential flakiness.)

Once the robot has been spawned in the simulated world, a demo application can
be started by executing the following:

.. code:: command

   $ roslaunch fetch_gazebo_demo demo.launch


Issues
------

The robot will refuse to move unless all `model` references are removed from
the URDF file. As a temporary workaround, those file references can be replaced
with absolute paths via the following command:

.. code:: command

   $ sed -i "s#model://#/ros_ws/src/fetch_gazebo/fetch_gazebo/robots/#g" /ros_ws/src/fetch_gazebo/fetch_gazebo/robots/fetch/fetch.gazebo.urdf


References
----------

* https://answers.gazebosim.org//question/14625/running-a-camera-sensor-headless
