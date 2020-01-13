## Install CARLA on a virtual machine

A CARLA install consists of the CARLA server and one or more CARLA clients. This install tutorial walks 
you through the installation of version 0.9.7 for both client and server. It is very likely newer versions
will be available when you read this repo. You can continue to use 0.9.7, or adjust these instructions to
download newer versions when available.

### CARLA server

Use the Ubuntu Desktop you setup in [Step 1](./Step1-AWS.md) to open a browser to [https://github.com/carla-simulator/carla/releases](https://github.com/carla-simulator/carla/releases). 

#### Download and extract the server source files

* Locate the 0.9.7 release.
* Download __CARLA_0.9.7.tar.gz__.
* Open a terminal on your Linux desktop and create a new directory:

        mkdir ~/CARLA

* Once the CARLA archive has downloaded, click the "Extract" button in the GUI. Extract the contents to this new folder.

#### Create a Python environment

* In the Linux desktop terminal you opened above, create a new Conda environment. Conda allows you to manage multiple Python installs, and keeps your dependencies from colliding with other projects

        conda create -n carla python=3.7

* After the envrionment creation completes, activate it:

        source activate carla

* Install Python dependencies:

        cd ~/CARLA
        pip install pygame numpy

You are now ready for [Step 3-Build and Install Unreal Engine](Step3-Unreal.md)



