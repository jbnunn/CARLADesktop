## Build Unreal Engine

CARLA uses the Unreal Engine for simulation. To complete this task, you'll need to

1) Connect your Github account to Unreal
2) Download the Unreal repo

### Connect your Github account to Unreal

1. Visit [https://www.unrealengine.com/en-US/](https://www.unrealengine.com/en-US/)
2. Create an account or sign in
3. Connect your Github profile to your Unreal account

This will allow you to proceed to the next step

### Download Unreal Engine

In a terminal for your Ubuntu server, download the Unreal Engine code. This tutorial downloads version 4.22.

    git clone --depth=1 -b 4.22 git@github.com:EpicGames/UnrealEngine.git ~/UnrealEngine_4.2

### Setup Unreal Engine

Note: This is the longest part of the tutorial, and will take up to two hours to complete.

    ./Setup.sh && ./GenerateProjectFiles.sh && make

When the build completes, you're ready for [Step 4 - Run a Simulation](Step4-Simulate.md).
