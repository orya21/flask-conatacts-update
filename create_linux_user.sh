#!/bin/bash

# create a user called gagi
adduser -q gagi

# add user to sudoers group
usermod -aG sudo gagi

# switch to gagi
su - gagi