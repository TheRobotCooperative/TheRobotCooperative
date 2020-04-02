VNC
===

Usage
-----

From the inside the Docker container, launch a VNC server:

.. code:: command

   # vnc4server -geometry 1400x1000

   root@b1230b0ab6c0:/# vnc4server -geometry 1400x1000
   xauth:  file /root/.Xauthority does not exist

   New 'b1230b0ab6c0:1 ()' desktop is b1230b0ab6c0:1

   Starting applications specified in /root/.vnc/xstartup
   Log file is /root/.vnc/b1230b0ab6c0:1.log


Next, and most importantly, you must update your :code:`DISPLAY` environment
variable to match the name of the created display, and then you may launch
the desktop environment inside the virtual display.

.. code:: command

   # export DISPLAY="6505c5e0a265:1"
   # startxfce4 &

Obtain the IP address of the container, which is :code:`172.17.0.2` in this
example, and connect to the VNC server, assumed to be :code:`:1`:

.. code:: command

   $ vncviewer 172.17.0.2:1

When prompted, login using the password :code:`password`.
