#!/bin/sh

# Connect to VPN
sudo openvpn --config /etc/openvpn/vpn.ovpn & \
    sleep 30 & \
    curl ipinfo.io

# iptables configuration
./iptables.sh
./route.sh