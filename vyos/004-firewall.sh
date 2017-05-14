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

set firewall name WAN_IN default-action drop
set firewall name WAN_IN rule 10 action accept
set firewall name WAN_IN rule 10 state established enable
set firewall name WAN_IN rule 10 state related enable

set firewall name WAN_LOCAL default-action drop
set firewall name WAN_LOCAL rule 10 action accept
set firewall name WAN_LOCAL rule 10 state established enable
set firewall name WAN_LOCAL rule 10 state related enable
set firewall name WAN_LOCAL rule 20 action drop
set firewall name WAN_LOCAL rule 20 protocol icmp
set firewall name WAN_LOCAL rule 20 icmp type-name echo-request

set firewall name WLAN_IN default-action accept
set firewall name WLAN_IN rule 10 action drop
set firewall name WLAN_IN rule 10 destination address 10.10.0.0/16
set firewall name WLAN_IN rule 10 state new enable
set firewall name WLAN_IN rule 10 protocol all
set firewall name WLAN_IN rule 20 action drop
set firewall name WLAN_IN rule 20 destination address 192.168.0.0/16
set firewall name WLAN_IN rule 20 state new enable
set firewall name WLAN_IN rule 20 protocol all

set firewall name WLAN_LOCAL default-action drop
set firewall name WLAN_LOCAL rule 10 action accept
set firewall name WLAN_LOCAL rule 10 destination port 53
set firewall name WLAN_LOCAL rule 10 protocol udp
set firewall name WLAN_LOCAL rule 20 action accept
set firewall name WLAN_LOCAL rule 20 destination port 67
set firewall name WLAN_LOCAL rule 20 protocol udp

set interfaces ethernet eth0 firewall in name WAN_IN
set interfaces ethernet eth0 firewall local name WAN_LOCAL
set interfaces ethernet eth1 vif 20 firewall in name WLAN_IN
set interfaces ethernet eth1 vif 20 firewall local name WLAN_LOCAL

commit
save
exit
