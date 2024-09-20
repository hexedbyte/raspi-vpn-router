#!/bin/bash
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT
sudo iptables -A FORWARD -i tun0 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
