#!/bin/bash

#install telerising
sudo docker run \
  -d \
  -e USER_ID="99" \
  -e GROUP_ID="100" \
  -e TIMEZONE="Europe/Berlin" \
  -e UPDATE="yes" \
  -p 5000:5000 \
  -v /etc/telerising:/telerising \
  --name=new-telerising-api \
  --restart unless-stopped \
  --tmpfs /tmp \
  --tmpfs /var/log \
  --net="bridge" \
  takealug/new-telerising-api:latest

