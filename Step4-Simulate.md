## Run a Simulation

### Open a terminal in your virtual Ubuntu deskop

    ssh -i "your.pem" -L 5901:localhost:5901 ubuntu@ec2-11-222-33-444.compute-1.amazonaws.com

### Start the CARLA server

```
SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -carla-server
```

This should lead to the output of 

```
A_DEVICE=0 ./CarlaUE4.sh
4.22.1-0+++UE4+Release-4.22 517 0
Disabling core dumps.

```

and indicate that the server is running.

### Start a CARLA client

* Leave the server running in a terminal, and open another on your virtual desktop. By default, this terminal starts with Python 3. We'll need Python 2 for this example. Activate the environment you created previously with

        source activate carla

* Change directories to the `examples` directory

        cd ~/CARLA/PythonAPI/examples

Follow the examples below to launch a windowed view of the simulator with actors in various scenarios:

#### Manual control of a character in the game

        python manual_control.py

More samples soon...

