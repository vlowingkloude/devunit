#!/bin/bash

export DEVUNITPASSWORD=password
export DEV_USER=dev
export EMAIL=nosuch@e.mail

container build --build-arg DEVUNITPASSWORD=$DEVUNITPASSWORD --build-arg DEV_USER=$DEV_USER --build-arg EMAIL=$EMAIL -t devunitbase .
