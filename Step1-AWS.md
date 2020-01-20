## Create a GPU-based VM on AWS

* From the [EC2 console](https://console.aws.amazon.com/ec2/v2/), click the **Launch Instance** button, then click on the "AWS Marketplace" tab in the left navigation.
* In the search box, search for "ubuntu deep learning", then click the **Select** button.

![marketplace](img/ami-aws-marketplace.png)

* The AMI is optimized for graphical and deep learning applications, and comes with many deep learning frameworks. What we really want out of it are pre-installed NVIDIA drivers. [You can read more about the AMI here.](https://aws.amazon.com/marketplace/pp/B077GCH38C?ref=cns_srchrow) 

* Use the wizard to follow the the steps to launch your image on an EC2 machine. Currently, the most cost-effective instance type is the __g3s.xlarge__. 

You will need to open the follwing inbound ports when creating a security group:

    TCP port 22 for SSH
    TCP ports 2000-2002 for CARLA server

![security-group](img/sg.png)

For each of those ports, take care to make the source IP as specific as possible, especially for SSH. In most cases, you should only enable access to your IP by using the "My IP" option when creating inbound rules.

## Setup your VM

* Once your VM has launched, SSH into it. Run the following commands to configure your machine:

```
# VNC and xterm
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal xfce4 vnc4server xterm

# Install lubuntu
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y lubuntu-desktop

# OpenGL
sudo apt-get install -y freeglut3-dev mesa-utils

# VirtualGL
wget https://sourceforge.net/projects/virtualgl/files/2.6.3/virtualgl_2.6.3_amd64.deb/download -O virtualgl_2.6.3_amd64.deb
sudo dpkg -i virtualgl*.deb
rm virtualgl*.deb

# TurboVNC
wget https://sourceforge.net/projects/turbovnc/files/2.2.3/turbovnc_2.2.3_amd64.deb/download -O turbovnc_2.2.3_amd64.deb 
sudo dpkg -i turbovnc*.deb
rm turbovnc*.deb

# Extra packages
sudo apt install -y libxrandr-dev

# Clean up
sudo apt-get clean && \
sudo apt-get autoremove && \
sudo rm -r /var/lib/apt/lists/*
```

## Connect with a VNC Client

Log out of the instance, then log back in with port forwarding, substituting the `your.pem` and `ec2-11-222...` portion below with your key and the IP address of your EC2 instance

    ssh -i "your.pem" -L 5901:localhost:5901 ubuntu@ec2-11-222-33-444.compute-1.amazonaws.com

### Update your VNC settings

Replace the contents of ~/.vnc/xstartup with the following:

```
#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
dbus-launch xfce4-session

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources

xsetroot -solid grey

vncconfig -iconic &
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal
```

Then, modify the permissions of the file you just created:

    chmod +x ~/.vnc/xstartup

### Start the VNC server

Any time you want to connect via VNC remotely, you'll need to use the following command. Let's run it now:

    vncserver -geometry 1920x1080

### Connect to your EC2 server with a VNC client

Your EC2 server is now listening for connections. Use a VNC client (like RealVNC) to connect with your server. Because we forwarded port 5901, we will connect to that port. You'll login with the same password you entered while setting up the VM earlier in this document.

![vnc](img/vnc.png)

If you see the desktop of your EC2 instance, you're ready for [Step 2-Install CARLA](Step2-CARLA.md).

