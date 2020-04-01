VNC
===

Usage
-----

To launch a VNC server inside the Docker container:

.. code:: command

   $ vncserver

To check that the VNC server is actually running:

.. code:: command

   $ vncserver -list

To kill the VNC server inside the Docker container, assuming that server
:code:`:1` is being used:

.. code:: command

   $ vncserver -kill :1
