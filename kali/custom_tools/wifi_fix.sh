#!/bin/bash
# run with sudo privileges

# unload modules

rmmod iwlmvm; sleep 1
rmmod iwlwifi; sleep 1

# load modules
modprobe iwlwifi; sleep 1

nmcli devices # display status
# if it's disconnected that's good driver is working
