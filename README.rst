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

Image installation
-------------------

To build a Docker image for a particular robot with VNC support enabled, simply
execute :code:`make` with name of the robot that you wish to build.
For example, to build the image for :code:`fetch`, execute the following:

.. code:: command

   $ make fetch

For more advanced uses, you manually build the image for a particular robot by
using the provided :code:`Dockerfile` at the root of the repository and
supplying the appropriate build arguments (documented at the top of
:code:`Dockerfile`). For example, to build a slimmer, headless image for
:code:`fetch`, running on ROS Melodic, without support for VNC, execute the
following from the root of the repository:

.. code:: command

   $ docker build \
         --build-arg VNC=no \
         --build-arg DISTRO=melodic \
         --build-arg DIRECTORY=fetch \
         -t fetch .

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

*Mac OS X:* If you are using Mac OS X, you cannot interact directly with a
container via its IP address. To get around this problem, you will need to
use port forwarding to forward the VNC port 5900 to the host, which can be
achieved by adding a :code:`-p 5900` option to the :code:`docker run` command
used to launch the container, as shown below.

.. code:: command

   $ docker run -p 5900 --rm -it name_of_image
   ...
   $ vncviewer 172.0.0.1

When prompted, login using the password :code:`password`

.. image:: images/vnc-login.png

Assuming that everything goes to plan, you should see a desktop that looks something
like this:

.. image:: images/vnc-desktop.png

You should continue to work inside the virtual desktop using your VNC client.
Below is an example of running the Fetch simulation inside the virtual desktop.

.. image:: images/vnc-fetch.png

If you wish to modify the resolution of the virtual desktop, you can edit the
following line inside :code:`/etc/supervisor/conf.d/supervisord.conf` before
running :code:`/startup-vnc.sh`.

.. code::

   command=/usr/bin/Xvfb :1 -screen 0 1024x768x16
