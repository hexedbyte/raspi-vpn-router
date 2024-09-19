#!/bin/sh
sudo ip route del default via 192.168.0.1 dev wlan0
sudo ip route del default via 192.168.0.1 dev eth0

sudo ip route add default via 192.168.0.1 dev wlan0
sudo ip route add default via 192.168.4.1 dev eth0

ip route
