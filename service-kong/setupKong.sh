#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

currDir=`pwd`
cd docker-kong/compose

echo "Build the image"
docker-compose build
