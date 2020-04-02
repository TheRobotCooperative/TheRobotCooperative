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

Using VNC to provide visualisation
..................................

To launch a VNC server from the inside the Docker container:

.. code:: command

   # /startup-vnc.sh

To connect to the VNC server from the host machine, first obtain the IP address
of the container (e.g., :code:`172.17.0.2`), and use a VNC client to connect to
the server:

.. code:: command

   $ vncviewer 172.17.0.2:1

When prompted, login using the password :code:`password`

.. image:: vnc-login.png
