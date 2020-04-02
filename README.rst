The Robot Cooperative
=====================

This repository is designed to make it easier for software engineering and
robotics researchers to interact with and experiment on robot software by
providing Docker images for a variety of open-source robots written for the
Robot Operating System.
Each Docker image is accompanied by example code and usage instructions,
and can be used to launch a robot in simulation using Gazebo,
and comes with VNC support for visualisation.
(For some images, we also provide GzWeb support as an experimental, alternative
means of visualisation.)


Usage
-----

Below we provide general instructions for using the images provided by the
repository. Specific instructions on how to use an image for a particular robot
can be found in the associated directories for those robots.

Using VNC to provide visualisation
..................................

To launch a VNC server from the inside the Docker container:

.. code:: command

   $ /startup-vnc.sh

To connect to the VNC server from the host machine, first obtain the IP address
of the container (e.g., :code:`172.17.0.2`), and use a VNC client to connect to
the server:

.. code:: command

   $ vncviewer 172.17.0.2:0

When prompted, login using the password :code:`password`

.. image:: images/vnc-login.png

Assuming that everything goes to plan, you should see a desktop that looks something
like this:

.. image:: images/vnc-desktop.png
