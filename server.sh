/opt/TurboVNC/bin/vncserver -kill :1
/opt/TurboVNC/bin/vncserver
cd CARLA
SDL_VIDEODRIVER=offscreen ./CarlaUE4.sh -carla-server
