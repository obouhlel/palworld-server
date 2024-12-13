#!/bin/sh

steamcmd +login anonymous +app_update 2394010 validate +quit

cp /home/steam/PalWorldSettings.ini /home/steam/.steam/steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini

sh /home/steam/.steam/steam/steamapps/common/PalServer/PalServer.sh