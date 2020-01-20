## Install CARLA on a virtual machine

A CARLA install consists of the CARLA server and one or more CARLA clients. This install tutorial walks 
you through the installation of version 0.9.5 for both client and server. As of this writing, 0.9.7 exists,
but has inconsistencies with the Python tooling available. We'll continue this project in 0.9.5 until CARLA 
becomes more stable.

### CARLA server

#### Download and extract the server source files

1. SSH into your EC2 server

        ssh -i "your.pem" -L 5901:localhost:5901 ubuntu@ec2-11-222-33-444.compute-1.amazonaws.com

2. Download [https://github.com/carla-simulator/carla/releases/tag/0.9.5]:

        cd ~
        wget http://carla-assets-internal.s3.amazonaws.com/Releases/Linux/CARLA_0.9.5.tar.gz
        gunzip CARLA_0.9.5.tar.gz
        mkdir CARLA && cd CARLA
        tar -xvf ../CARLA_0.9.5.tar

#### Create a Python environment

* In the Linux desktop terminal you opened above, create a new Conda environment. Conda allows you to manage multiple Python installs, and keeps your dependencies from colliding with other projects

        conda create -n carla python=2.7

* After the envrionment creation completes, activate it:

        source activate carla

* Install Python dependencies:

        pip install pygame numpy
        pip install carla==0.9.5

You are now [ready for Step 3-Simulate!](./Step3-Simulate.md)



