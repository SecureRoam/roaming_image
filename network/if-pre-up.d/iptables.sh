#!/bin/bash

iptables-restore < /etc/iptables.test.rules

# Flush all existing rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
 iptables -A INPUT -p tcp -i wlan0 --dport 22 -j ACCEPT
 iptables -A INPUT -p tcp -i wlan0 --dport 22 -j ACCEPT
iptables -t mangle -F
iptables -t mangle -X

# Block all incoming ICMP echo requests (ping)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Allow all related and established connections
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Allow incoming HTTP and HTTPS
iptables -A INPUT -p tcp -i wlan0 --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -i wlan0 --dport 443 -j ACCEPT

# If no rule matched, drop the packet
iptables -P INPUT DROP
iptables -A INPUT -p tcp -i wlan0 --dport 443 -j ACCEPT
