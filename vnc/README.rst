VNC
===

Usage
-----

From the inside the Docker container, launch a VNC server:

.. code:: command

   # vncserver

Obtain the IP address of the container, which is :code:`172.17.0.2` in this
example, and connect to the VNC server, assumed to be :code:`:1`:

.. code:: command

   $ vncviewer 172.17.0.2:1
