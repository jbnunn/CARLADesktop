## Run a Simulation

By the end of step, you'll have a working CARLA simulation running in a VNC window.

![img/drive.png](Simulation)

### Connect to your EC2 instance

SSH into your EC2 instance. Don't forget to replace the `ec2-11-222-33-444...amazonaws.com` address with your EC2 instance's address.

    ssh -i "your.pem" -L 5901:localhost:5901 ubuntu@ec2-11-222-33-444.compute-1.amazonaws.com

### Start VNC

We need to start a TurboVNC server (which will open the black screen like you opened in [Step 1](./Step1-AWS)). Kill any existing sessions, then start the server:

    /opt/TurboVNC/bin/vncserver -kill :1
    /opt/TurboVNC/bin/vncserver

### Open a VNC connection

If you haven't already, use a VNC client to connect to `localhost:5901`.

![vnc.png](img/vnc.png)

### Start the CARLA server

```
SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -carla-server
```

This should lead to a lot of output, but it should eventually get to a waiting state, indicating that it is ready to listen for connections:

![img/linux.png](CARLA Server)

### Start a CARLA client

* Leave the server running in a terminal, and create a new SSH session in your EC2 instance:

    ssh -i "your.pem" -L 5901:localhost:5901 ubuntu@ec2-11-222-33-444.compute-1.amazonaws.com

* Set your Python environment

    source activate carla

* Change directories to the `examples` directory

    cd ~/CARLA/PythonAPI/examples

Follow the examples below to launch a windowed view of the simulator with actors in various scenarios:

#### Manual control of a character in the game

    python manual_control.py

More samples soon...

