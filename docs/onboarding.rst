Getting Started
=================

Follow the Getting Started instructions in The Robot Cooperative to
prepare your machine will all of the necessary prerequisites:
https://github.com/TheRobotCooperative/TheRobotCooperative

Docker
------

The Robot Cooperative provides Docker container image that we will use to study
different robots. Docker containers are conceptually similar to virtual machines (VMs).
They use operating system-level virtualisation to provide you with access to a
sandbox that looks like a real computer from the perspective of the programs
running inside of them. In contrast to VMs, containers are much smaller and faster
since they use the kernel of the host machine (i.e., the computer that is running
the container) rather than virtualising hardware.

For the purpose of conducting research on robot software, we use Docker
images for the following reasons:

1. they avoid tedious, error-prone, and time-consuming manual installation
   processes.
2. they provide reproducibility: images should (typically) behave the same on
   different machines.
3. we can run lots of virtual robots on the same machine, which is handy
   when conducting experiments.

We encourage you to familiarise yourself with Docker: You should know how to
(a) launch Docker containers from the command line, and (b) create new Docker
images by writing a Dockerfile. You shouldn't need to dive too deeply into
Docker, but in general, the skills that you learn should prove helpful to you
in other pursuits: Docker is widely used in industry to deploy software systems
(e.g., Google, Netflix, Amazon).

* https://docker-curriculum.com/
* https://docs.docker.com/get-started/

**Note that, unlike most VMs, containers are ephemeral and will be destroyed
once you finish using them or the machine powers down.** To that end, you
should not plan to persist state inside a container: You should either create
a new Docker image, or use `volume mounting <https://docs.docker.com/storage/volumes/>`_
to share files between the host and container. You likely won't need to worry
too much about persisting state early on in the summer, so you don't need to
look into this too much.


Robot Operating System
======================

All of the robots in The Robot Cooperative are built on top of the Robot
Operating System (ROS). ROS is the most popular software framework for building
robot software for a wide array of robotic systems (e.g., quadcopters, self-driving
cars, mobile robots, industrial robotic arms, etc.), and is sometimes referred
to as the "Linux of Robotics". Despite the name, ROS is not an actual operating
system (e.g., Linux, Mac, Windows), but rather a software framework, set of tools,
communication protocols, and a growing library of reusable, modular components that
form an ecosystem.

Before getting started, you should check out the following materials to get a broad
overview of the capabilities, motivation, and structure of ROS:

* https://www.ros.org/about-ros/
* https://www.ros.org/is-ros-for-me/
* https://www.ros.org/core-components/


Demonstration: TurtleBot 3
==========================

For the rest of these instructions, we'll be using The Robot Cooperative to
study TurtleBot 3, a popular mobile robot that can be built in different
configurations: http://www.robotis.us/turtlebot-3/

Your first step should be to build the Docker image for TurtleBot 3 on your
own machine. To do so, you should execute the following from the root of
the repository

.. code::

   $ make turtlebot3

You can then launch a Docker container for TurtleBot 3 via the following:

.. code::

   $ docker run --rm -it turtlebot3

You should now find yourself inside a (root) Bash shell for this robot system!
Take a look around and explore the file system: Don't worry about breaking
anything -- since containers are ephemeral, you can just discard your existing
container and start a new one from the TurtleBot 3 image that we built earlier.
An interesting place to look at for now is `/ros_ws`: This is the
workspace that is used by ROS's build system, `catkin <http://wiki.ros.org/catkin/conceptual_overview>`_.

Looking at the text output of a shell is only fun for so long for most
of us: Let's get a virtual desktop up and running using VNC. To do so,
follow these instructions: https://github.com/TheRobotCooperative/TheRobotCooperative#using-vnc-to-provide-visualisation

Once you can see a virtual desktop, we're ready to launch a simulation
of the robot. To do so, you will use the `roslaunch` command to bring
up the system. A detailed set of instructions with nice visuals that
guides you through the TurtleBot 3 simulation process can be found
here: http://emanual.robotis.com/docs/en/platform/turtlebot3/simulation/#ros-1-simulation

You should try to work through each of the examples in the tutorial above.
We expect that this may take you some time.

As you work hands-on with the robot, you should also read up on the Robot
Operating System to understand (at a high-level) how the robot is working.
The following resources are a great starting point for that:

* http://wiki.ros.org/ROS/Tutorials
* http://wiki.ros.org/ROS/Introduction
* https://www.cse.sc.edu/~jokane/agitr/


Python
======

Over the course of the summer, you will likely read and write a lot of Python
code. Python is a great language for interacting with ROS-based systems.
(Although Python is slower than, say, C++, the bottlenecks of ROS systems are
elsewhere, so in practice, you pay little to no performance penalty for using
Python.)
Writing Python programs is fairly easy, but writing good Python programs
can be deceptively hard. To help you write better code that has fewer bugs
and is easier to maintain, you will use a number of tools:

* We will use Python 3 rather than the now deprecated Python 2.7.
  Any version of Python greater than or equal to 3.6 should suffice, and
  is _likely_ the default provided by your OS / distro. If that isn't the
  case, then let us know.
* We will use `Pipenv <https://pipenv.pypa.io/en/latest/>`_ to create a virtual
  environment for each of our projects. Essentially, a virtual environment allows
  us to maintain a separate set of installed packages for each of our projects,
  and avoids the need to install packages to the system installation. Installing
  Python packages with either `sudo pip install` or `pip install`, while a quick
  fix, can lead to very serious problems (e.g., `dependency hell <https://en.wikipedia.org/wiki/Dependency_hell>`_)
  that may ultimately require you to reinstall your OS.
* We will `add type annotations <https://github.com/python/mypy>`_ to our code,
  and use `mypy <https://github.com/python/mypy>`_ to perform static type
  checking to spot bugs before runtime.
* We will use `flake8` to lint our code and enforce a particular set of coding
  conventions. In this case, we'll use Python's official style guide:
  `PEP8 <https://www.python.org/dev/peps/pep-0008/>`_.
* Finally, we will use `tox` to automate all of this linting, type checking,
  and testing for us, so that we only need to run a single command from the
  shell to check that our project is good.


Continuous Integration: GitHub Actions or Travis CI
===================================================

To reap the benefits of all of the Python tools described above, you will use
continuous integration to run all of those checks every time you commit code to
our Git repositories. For the most part, our existing repositories use `Travis
CI <https://travis-ci.org/>`_ to perform continuous integration, but it may be
worth exploring the newly introduced `GitHub Actions <https://github.com/features/actions>`_ as an alternative.
