#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

set firewall all-ping enable
set firewall broadcast-ping disable
set firewall ip-src-route disable
set firewall log-martians disable
set firewall receive-redirects disable
set firewall send-redirects enable
set firewall source-validation disable
set firewall syn-cookies enable

set firewall name WAN_IN
set firewall name WAN_IN description 'WAN_IN'
set firewall name WAN_IN default-action drop
set firewall name WAN_IN rule 1 action accept
set firewall name WAN_In rule 1 description "Allow Established / Related Traffic"
set firewall name WAN_IN rule 1 state established enable
set firewall name WAN_IN rule 1 state related enable
set firewall name WAN_IN rule 2 action drop
set firewall name WAN_IN rule 2 description "Drop ICMP"
set firewall name WAN_IN rule 2 protocol icmp
set firewall name WAN_IN rule 2 icmp type 8

set firewall name PROTECT_IN default-action accept
set firewall name PROTECT_IN rule 1 action drop
set firewall name PROTECT_IN rule 1 description 'Drop new connections from WLAN to LAN'
set firewall name PROTECT_IN rule 1 destination address 10.10.0.0/16
set firewall name PROTECT_IN rule 1 state new enable
set firewall name PROTECT_IN rule 1 protocol all
set firewall name PROTECT_IN rule 2 action drop
set firewall name PROTECT_IN rule 2 description 'Drop new connections from WLAN to WANs LAN'
set firewall name PROTECT_IN rule 2 destination address 192.168.0.0/16

set firewall name PROTECT_LOCAL default-action drop
set firewall name PROTECT_LOCAL rule 1 action accept
set firewall name PROTECT_LOCAL rule 1 description 'Allow DNS'
set firewall name PROTECT_LOCAL rule 1 destination port 53
set firewall name PROTECT_LOCAL rule 1 protocol udp
set firewall name PROTECT_LOCAL rule 2 action accept
set firewall name PROTECT_LOCAL rule 2 description 'Accept DHCP'
set firewall name PROTECT_LOCAL rule 2 destination port 67
set firewall name PROTECT_LOCAL rule 2 protocol udp

commit
save
exit
