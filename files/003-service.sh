#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

set service gui older-ciphers disable
set service ssh protocol-version v2
set service ubnt-discover disable

set service nat rule 1 description "Masquerade from LAN to eth0 WAN"
set service nat rule 1 source address 10.10.0.0/16
set service nat rule 1 type masquerade
set service nat rule 1 outbound-interface eth0
set service nat rule 1 protocol all
set service nat rule 1 log disable

set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 default-router 10.10.50.1
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 start 10.10.50.10 stop 10.10.50.100
set service dhcp-server shared-network-name ERX_MANAGEMENT description 'ERX_MANAGEMENT'

set service dhcp-server shared-network-name LAN description 'LAN'
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 default-router 10.10.10.1
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 start 10.10.10.10 stop 10.10.10.100

set service dhcp-server shared-network-name WLAN description 'WLAN'
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 default-router 10.10.20.1
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 start 10.10.20.10 stop 10.10.20.100

set service dhcp-server shared-network-name WLAN_MANAGEMENT description 'WLAN_MANAGEMENT'
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 default-router 10.10.30.1
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 start 10.10.30.10 stop 10.10.30.100

set service dns forwarding listen-on eth4
set service dns forwarding listen-on eth5
set service dns forwarding listen-on eth5.10
set service dns forwarding listen-on eth5.20
set service dns forwarding listen-on eth5.30

set service gui listen-address 10.10.50.1
set service ssh listen-address 10.10.50.1

commit
save
exit
