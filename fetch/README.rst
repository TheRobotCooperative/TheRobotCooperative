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
