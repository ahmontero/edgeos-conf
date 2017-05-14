#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

net nat source rule 1 description "Masquerade from LAN to eth0 WAN"
set nat source rule 1 outbound-interface eth0
set nat source rule 1 source address 10.10.0.0/16
set nat source rule 1 translation address masquerade

set firewall all-ping enable
set firewall broadcast-ping disable
set firewall ip-src-route disable
set firewall log-martians enable
set firewall receive-redirects disable
set firewall send-redirects disable
set firewall source-validation disable
set firewall syn-cookies enable

#set firewall state-policy established action accept
#set firewall state-policy related action accept
#set firewall state-policy invalid action drop

set firewall group network-group 'BLACKLISTED' network 1.1.1.1/32
set firewall group network-group 'LAN_SUBNETS' network 10.10.0.0/16
set firewall group network-group 'WAN_ROUTER_SUBNET' network 192.168.0.0/16
set firewall group network-group 'MANAGEMENT' network 10.10.10.0/24
set firewall group network-group 'MANAGEMENT' network 10.10.30.0/24

set firewall name WAN_LOCAL
set firewall name WAN_LOCAL default-action drop
set firewall name WAN_LOCAL rule 1000 action drop
set firewall name WAN_LOCAL rule 1000 source group network-group 'BLACKLISTED'
set firewall name WAN_LOCAL rule 1010 action accept
set firewall name WAN_LOCAL rule 1010 state established enable
set firewall name WAN_LOCAL rule 1010 state related enable
set firewall name WAN_LOCAL rule 1011 action drop
set firewall name WAN_LOCAL rule 1011 state invalid enable
set firewall name WAN_LOCAL rule 1020 action accept
set firewall name WAN_LOCAL rule 1020 icmp type-name echo-request
set firewall name WAN_LOCAL rule 1020 protocol icmp
set firewall name WAN_LOCAL rule 1020 state new enable
set firewall name WAN_LOCAL rule 1100 action drop
set firewall name WAN_LOCAL rule 1100 destination port 22
set firewall name WAN_LOCAL rule 1100 protocol tcp
set firewall name WAN_LOCAL rule 1100 recent count 4
set firewall name WAN_LOCAL rule 1100 recent time 60
set firewall name WAN_LOCAL rule 1100 source group network-group 'MANAGEMENT'
set firewall name WAN_LOCAL rule 1100 state new enable

set firewall name WAN_IN
set firewall name WAN_IN description 'WAN_IN'
set firewall name WAN_IN default-action drop
set firewall name WAN_IN rule 1 action accept
set firewall name WAN_IN rule 1 description "Allow Established / Related Traffic"
set firewall name WAN_IN rule 1 state established enable
set firewall name WAN_IN rule 1 state related enable
set firewall name WAN_IN rule 2 action drop
set firewall name WAN_IN rule 2 description "Drop ICMP"
set firewall name WAN_IN rule 2 protocol icmp
set firewall name WAN_IN rule 2 icmp type 8

set firewall name LAN_IN default-action accept
set firewall name LAN_IN rule 1 action drop
set firewall name LAN_IN rule 1 description 'Drop new connections from WLAN to LAN'
set firewall name LAN_IN rule 1 source group network-group 'LAN_SUBNETS'
set firewall name LAN_IN rule 1 state new enable
set firewall name LAN_IN rule 1 protocol all
set firewall name LAN_IN rule 2 action drop
set firewall name LAN_IN rule 2 description 'Drop new connections from WLAN to WAN'
set firewall name LAN_IN rule 2 source group network-group 'WAN_ROUTER_SUBNET'
set firewall name LAN_IN rule 2 state new enable
set firewall name LAN_IN rule 2 protocol all

set firewall name LAN_LOCAL default-action drop
set firewall name LAN_LOCAL rule 1 action accept
set firewall name LAN_LOCAL rule 1 description 'Allow DNS'
set firewall name LAN_LOCAL rule 1 destination port 53
set firewall name LAN_LOCAL rule 1 protocol udp
set firewall name LAN_LOCAL rule 2 action accept
set firewall name LAN_LOCAL rule 2 description 'Accept DHCP'
set firewall name LAN_LOCAL rule 2 destination port 67
set firewall name LAN_LOCAL rule 2 protocol udp

set interfaces ethernet eth0 firewall in name WAN_IN
set interfaces ethernet eth0 firewall local name WAN_IN
set interfaces ethernet eth1 vif 20 firewall in name LAN_IN
set interfaces ethernet eth1 vif 20 firewall local name LAN_LOCAL

commit
save
exit
