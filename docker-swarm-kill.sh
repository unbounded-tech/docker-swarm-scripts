#!/usr/bin/env bash

while true; do
    printf "\nWARNING: This will stop all running docker-machine's!\n\n"
    printf "Below are your running machines:\n"

    docker-machine ls --filter state=running

    read -p "Are you sure you wish to continue? [y/n] " yn
    case $yn in
        [Yy]* )
            # Kill all running machines
            docker-machine ls --filter state=running -q | xargs docker-machine stop
            break;;
        [Nn]* )
            exit;;
        * )
            echo "Please answer yes or no.";;
    esac
done
