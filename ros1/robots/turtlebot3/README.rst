TurtleBot3
==========

.. image:: robot.png


Status
------

It works!

.. image:: gzweb-progress.png


Usage
-----

Note that before running the simulation, the TurtleBot3 model that you wish
to use must be specified in the :code:`TURTLEBOT3_MODEL` environment variable.
The following models are supported: :code:`burger`, :code:`waffle`, and
:code:`waffle_pi`.

.. code::

   # export TURTLEBOT3_MODEL="burger"

After specifying the appropriate model, the TurtleBot can be launched in a
Gazebo simulation using the following command:

.. code::

   # roslaunch turtlebot3_gazebo turtlebot3_house.launch gui:=false

(Note that there are other simulated worlds where the robot can be launched.
Look inside the :code:`launch` directory of the :code:`turtlebot3_gazebo`
package for more details.)


Notes
-----

The :code:`gui` launch argument is currently ignored, and so the container will
attempt to launch the Gazebo GUI regardless of the value of that argument.


References
----------

* https://github.com/ROBOTIS-GIT/turtlebot3
* http://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/#turtlebot3-simulation-using-fake-node
