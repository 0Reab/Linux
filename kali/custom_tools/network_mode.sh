#!/bin/bash

# rerun network intreface for listening or normal usage
# run with sudo
# first arg - managed / monitor : in other words : normal / listener - respectively

MODE="$1"

function help {
	echo "Run with sudo"
	echo "arg = managed / monitor"
	exit 0
}


[[ "$MODE" == "help" || "$MODE" == "" ]] && help || echo "switching to $MODE"


# rerun with arg as mode

ip link set dev wlan0 down
iw dev wlan0 set type $MODE; sleep 0.2
ip link set dev wlan0 up

# show change
iw dev wlan0 info
