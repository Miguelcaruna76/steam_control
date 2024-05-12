#!/bin/bash


# Define the Docker volume name
VOLUME_NAME="steam_data"


create_volume() {
    # Create Docker volume
    docker volume create ${VOLUME_NAME}
}


start_container() {
    # Start Docker container with the created volume
    docker run -d --privileged -p 127.0.0.1:8083:8083 -v ${VOLUME_NAME}:/path/to/container/data josh5/steam-headless
}


stop_container() {
    # Stop Docker container
    docker stop $(docker ps -q --filter ancestor=josh5/steam-headless)
}


# Check if the argument is "start", "stop", or "create"
if [ "$1" == "start" ]; then
    start_container
elif [ "$1" == "stop" ]; then
    stop_container
elif [ "$1" == "create" ]; then
    create_volume
else
    echo "Usage: steam_control.sh [start|stop|create]"
    exit 1
fi

