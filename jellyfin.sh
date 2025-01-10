#!/bin/bash

#install Jellyfin as a docker container
sudo docker run -d \
  --name=jellyfin \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 8096:8096 \
  -p 8920:8920 `#optional` \
  -p 7359:7359/udp `#optional` \
  -p 1900:1900/udp `#optional` \
#  -v /path/to/jellyfin/library:/config \
#  -v /path/to/tvseries:/data/tvshows \
#  -v /path/to/movies:/data/movies \
  --restart unless-stopped \
  lscr.io/linuxserver/jellyfin:latest
