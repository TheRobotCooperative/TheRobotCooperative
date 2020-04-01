VNC
===

Usage
-----

From the inside the Docker container, launch a VNC server:

.. code:: command

   # vncserver

   New '6505c5e0a265:1 ()' desktop is 6505c5e0a265:1

   Creating default config /root/.vnc/config
   Starting applications specified in /root/.vnc/xstartup
   Log file is /root/.vnc/6505c5e0a265:1.log

Obtain the IP address of the container, which is :code:`172.17.0.2` in this
example, and connect to the VNC server, assumed to be :code:`:1`:

.. code:: command

   $ vncviewer 172.17.0.2:1

When prompted, login using the password :code:`password`.
