#!/bin/bash

#install telerising
docker run \
  -d \
  -e USER_ID="99" \
  -e GROUP_ID="100" \
  -e TIMEZONE="Europe/Berlin" \
  -e UPDATE="yes" \
  -e SSL_MODE="0" \
  -e NETWORK_DEVICE="eth0" \
  -e PORT="8180" \
  -e FFMPEG_HOST_LOCATION="/usr/bin/ffmpeg" \
  -e PROFILE="1" \
  -e AUDIO2="false" \
  -e DOLBY="false" \
  -e IGNORE_MAXRATE="false" \
  -e FFMPEG_LOGLEVEL="fatal" \
  -e ONDEMAND="false" \
  -p 8180:8180 \
  -v /etc/telerising:/telerising \
  --name=telerising-api \
  --restart unless-stopped \
  --tmpfs /tmp \
  --tmpfs /var/log \
  --net="bridge" \
  takealug/telerising-api:latest
