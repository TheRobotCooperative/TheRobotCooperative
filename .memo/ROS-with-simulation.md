This is a list of some ROS systems that have simulation. We can possibly use them for evaluation of our work.
------------------

1) Care-O-bot: an assistant robot. Here is a link to its GH [project](https://github.com/ipa320). It supports simulation with [Gazebo](https://github.com/ipa320/cob_simulation)

2) F1/10: It's an autonomous race car. It supports simulation with [Gazebo](https://github.com/f1tenth-dev/simulator). There's a [Docker](https://hub.docker.com/r/billyz/f110sim) image for it.

3) Parallel Parking: It's an autonomous parallel park. It's very simple and supports simulation in [Gazebo](https://github.com/Rohith-K/Autonomous-Parallel-Parking-Car-like-Robot-Gazebo-ROS).

4) UUV: Unmanned Underwater Vehicle. Simulation is [supported](https://uuvsimulator.github.io) and is very well maintained. I am not certain about how much of the control source code is open-source.

5) JetBot: Looks like a very simple rover. [Gazebo](https://github.com/dusty-nv/jetbot_ros) simulation.

6) Purdue Tutorial: This is a tutorial made by Purdue that has a very simple rover running around in [Gazaebo](https://github.com/SMARTlab-Purdue/ros-tutorial-gazebo-simulation).

7) FSAE: Driverless FSAE vehicles. Simulation with [Gazebo](https://github.com/eufsa/eufs_sim).

8) Obstacle Avoidance: This is really cool. It's a rover that avoids [obstacles](https://github.com/vibhuthasak/Obstacle_Avoidance_ROS).

9) Turtle War: This is a controller for TurtleBot but everything is in [Chinese](https://github.com/OneNightROBOCON/turtle_war).

#### Methodology

I searched `gazebo_ros in:package.xml` on GitHub to find these packages.
