# CARLA Desktop

[CARLA](http://carla.org), the open-source simulator for autonomous driving research, is notoriously painful to setup (as of Feb, 2020). The documentation is filled with version conflicts, outdated examples, and innacurate instructions. 

This repository provides instructions for getting a CARLA environment up and running. 

## Prerequisites

* An AWS account
* About 20 minutes of free time on your hands

## What you'll accomplish

By following the steps below, you will

* Launch and configure a virtual machine on Amazon Web Services (AWS) (~10 minutes)
* Install CARLA (~10 minutes)
* Simulate

When you've completed these steps, you'll have a working CARLA environment.

![CARLA](img/carla.gif)

# Get started

## Launch and configure a virtual machine on AWS

You will launch the [NVIDIA Gaming PC for Ubuntu 18.04 AMI](https://aws.amazon.com/marketplace/pp/B07SSKJMBJ?ref=cns_1clkPro). 

* From the [EC2 console](https://console.aws.amazon.com/ec2/v2/), click the **Launch Instance** button, then click on the "AWS Marketplace" tab in the left navigation.
* In the search box, search for "nvidia gaming pc ubuntu", then click the **Select** button.

![marketplace](img/ami-aws-marketplace.png)

* This AMI is optimized for GPU applications. Use the wizard to follow the steps to launch your image on an EC2 machine. Currently, the most cost-effective instance type for running CARLA is the __g4dn.xlarge__, which is $0.526/hr as of February 2020. Make sure to stop the instance when not in use to avoid high charges. 

### Modify the EC2 Security Group

Modify the EC2 security group for your instance. Allow TCP access on ports 22 and 4000 from your IP address. This will allow you to SSH into your machine and use NoMachine to connect to the desktop and view CARLA simulations.

![security-group](img/sg.png)

### Test initial installation

After the AMI boots, SSH into the machine and check `nvidia-smi` to confirm you have NVIDIA drivers by default. If you don't see something similar to the below, you've launched the wrong instance.

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.59       Driver Version: 440.59       CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
| N/A   45C    P8    16W /  70W |      0MiB / 15109MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

## Install NoMachine

NoMachine allows you to access the virtual machine render the simulation much faster than VNC. 

### First, install the server:

```
wget https://download.nomachine.com/download/6.9/Linux/nomachine_6.9.2_1_amd64.deb
sudo dpkg -i no*.deb
rm no*.deb
```

### Install a NoMachine client

Visit [https://www.nomachine.com/](https://www.nomachine.com/) to download a NoMachine client for your OS.

## Configure Ubuntu

### (Optional) Set an ubuntu password:

Setting a password is useful if you're going to be in the Ubuntu desktop a lot.

    sudo passwd ubuntu

### Install Ubuntu desktops

You'll use an Ubuntu desktop to give you GUI access to your CARLA simulation:

```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal xfce4 xterm
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y lubuntu-desktop
```

### Update graphics / utils

```
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev mesa-utils
sudo apt-get install -y libvulkan1 mesa-vulkan-drivers vulkan-utils
sudo apt update
sudo apt upgrade
```

### Install CUDA utils

```
sudo apt-get install -y nvidia-cuda-toolkit
```

## Install CARLA 0.9.8

Install CARLA 0.9.8 per [https://carla.readthedocs.io/en/latest/start_quickstart/](https://carla.readthedocs.io/en/latest/start_quickstart/](https://carla.readthedocs.io/en/latest/start_quickstart/](https://carla.readthedocs.io/en/latest/start_quickstart/):

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 304F9BC29914A77D
sudo add-apt-repository "deb [arch=amd64 trusted=yes] http://dist.carla.org/carla-0.9.8/ all main"
sudo apt-get update
sudo apt-get install carla
```

### Install Conda and create a CARLA environment

Use Conda to install Python 3 on the system and isolate the Python libraries CARLA needs:

```
cd /tmp
wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh
bash Anaconda3-2019.10-Linux-x86_64.sh
source ~/.bashrc
conda create -n carla python=3.5
conda activate carla
```

### Install CARLA Python requirements

Install the required libraries needed to run the simulation:


```
cd /home/ubuntu/CARLA/PythonAPI/carla/dist
easy_install carla-0.9.5-py3.5-linux-x86_64.egg

cd /home/ubuntu/CARLA/PythonAPI/carla
pip install -r requirements.txt

cd /home/ubuntu/CARLA/PythonAPI/examples
pip install -r requirements.txt
```

### Reboot and login with NoMachine

First, reboot:

    sudo reboot
    
After a few minutes, create a connection with the NoMachine client, using the Public DNS address of your EC2 machine:

![nomachine](img/nomachine.png)

* Choose Password authentication
* Leave "Don't use a proxy" selected
* Name your connection, then press done

When you've created the connection, open it, and login with your "ubuntu" username and password. After a few moments, you'll be presented with the Ubuntu login screen. After you sign in answer a few questions to setup your system, you'll be taken to your Ubuntu desktop:

![ubuntu](img/ubuntu.png)

## Run the CARLA Simulation

Open Ubuntu's terminal application. In one window, start the CARLA server:

    cd /home/ubuntu/CARLA
    SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -carla-server

In another terminal window (or tab), start the simulation:

    conda activate carla
    cd /home/ubuntu/CARLA/PythonAPI/examples
    python manual_control.py

# You're finished and ready to simulate!

![CARLA](img/carla.gif)
