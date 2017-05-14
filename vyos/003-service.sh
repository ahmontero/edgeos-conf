#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

set service dhcp-server shared-network-name MANAGEMENT description 'MANAGEMENT'
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.50.0/24 default-router 10.10.50.1
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.50.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.50.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.50.0/24 start 10.10.50.10 stop 10.10.50.100

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

set service dns forwarding listen-on eth1
set service dns forwarding name-server 8.8.8.8
set service dns forwarding name-server 8.8.4.4

set service snmp community vyos
set service snmp community vyos client 10.10.10.14
set service snmp community vyos authorization ro
set service snmp trap-target 10.10.10.14
set service snmp contact "Contact"
set service snmp description "Vyos"
set service snmp location "Location"

set service ssh
set service ssh listen-address 10.10.10.1
set service ssh port 22

commit
save
exit
