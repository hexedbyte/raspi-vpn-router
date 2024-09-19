#!/bin/sh

# Upgrade OS and packages
sudo apt update -y && sudo apt upgrade -y

# Install required packages
sudo apt install -y \
    openvpn \
    netfilter-persistent \
    dnsmasq \
    dhcpcd5

# Configure ethernet sharing - raspi as a router
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
if grep -q '^#net.ipv4.ip_forward' /etc/sysctl.conf; then
    sudo sed -i 's/^#net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
elif grep -q '^net.ipv4.ip_forward' /etc/sysctl.conf; then
    sudo sed -i 's/^net.ipv4.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
else
    sudo echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
fi
sudo sysctl -p

# Copy configurations
sudo cp ./dnsmasq.conf /etc/dnsmasq.conf
sudo cp ./dhcpcd.conf /etc/dhcpcd.conf

# Enable/Restart services
sudo systemctl restart openvpn
sudo systemctl enable dhcpcd
sudo systemctl restart dnsmasq
sudo systemctl restart dhcpcd

# Connect to VPN
sudo openvpn --config /etc/openvpn/vpn.ovpn & \
    sleep 30 & \
    curl ipinfo.io

# iptables configuration
sudo ./iptables.sh
sudo netfilter-persistent save