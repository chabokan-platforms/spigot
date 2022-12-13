#!/bin/bash

git clone https://github.com/tsl0922/ttyd.git
docker build . -t registry.chabokan.net/spigot-platform:1.18.2 -t registry.chabokan.net/spigot-platform:latest --build-arg VERSION=1.18.2 --build-arg JAVA_VERSION=17
rm -rf ttyd