#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

set system conntrack modules ftp disable
set system conntrack modules gre disable
set system conntrack modules h323 disable
set system conntrack modules pptp disable
set system conntrack modules sip disable
set system conntrack modules tftp disable

set system host-name bastion
set system name-server 8.8.8.8
set system ntp server 0.pool.ntp.org
set system ntp server 1.pool.ntp.org
set system ntp server 2.pool.ntp.org
set system ntp server 3.pool.ntp.org
set system offload hwnat enable
set system time-zone Europe/Madrid

set service gui older-ciphers disable
set service ssh protocol-version v2
set service ubnt-discover disable

set firewall all-ping enable
set firewall broadcast-ping disable
set firewall ip-src-route disable
set firewall log-martians disable
set firewall receive-redirects disable
set firewall send-redirects enable
set firewall source-validation disable
set firewall syn-cookies enable

delete interfaces ethernet eth0 address
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description WAN
set interfaces ethernet eth0 mac AA:AA:AA:AA:AA:AA
set interfaces ethernet eth0 dhcp-options client-option "send host-name &quot;VFHXXXXXXXXXX/XXXXXXXXX&quot;;"
set service nat rule 5010 description "Masquerade from LAN to eth0 WAN"
set service nat rule 5010 source address 10.10.0.0/16
set service nat rule 5010 type masquerade
set service nat rule 5010 outbound-interface eth0
set service nat rule 5010 protocol all
set service nat rule 5010 log disable

delete interfaces ethernet eth4 address
set interfaces ethernet eth4 address 10.10.50.1/24
set interfaces ethernet eth4 description 'ERX_MANAGEMENT'
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 default-router 10.10.50.1
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name ERX_MANAGEMENT subnet 10.10.50.0/24 start 10.10.50.10 stop 10.10.50.100
set service dhcp-server shared-network-name ERX_MANAGEMENT description 'ERX_MANAGEMENT'
set service dns forwarding listen-on eth4

delete interfaces ethernet eth5 address
set interfaces ethernet eth5 description 'TRUNK'
set service dns forwarding listen-on eth5

set interfaces ethernet eth5 vif 10 address 10.10.10.1/24
set interfaces ethernet eth5 vif 10 description 'LAN'
set service dhcp-server shared-network-name LAN description 'LAN'
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 default-router 10.10.10.1
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name LAN subnet 10.10.10.0/24 start 10.10.10.10 stop 10.10.10.100
set service dns forwarding listen-on eth5.10

set interfaces ethernet eth5 vif 20 address 10.10.20.1/24
set interfaces ethernet eth5 vif 20 description 'WLAN'
set service dhcp-server shared-network-name WLAN description 'WLAN'
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 default-router 10.10.20.1
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name WLAN subnet 10.10.20.0/24 start 10.10.20.10 stop 10.10.20.100
set service dns forwarding listen-on eth5.20

set interfaces ethernet eth5 vif 30 address 10.10.30.1/24
set interfaces ethernet eth5 vif 30 description 'WLAN_MANAGEMENT'
set service dhcp-server shared-network-name WLAN_MANAGEMENT description 'WLAN_MANAGEMENT'
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 default-router 10.10.30.1
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name WLAN_MANAGEMENT subnet 10.10.30.0/24 start 10.10.30.10 stop 10.10.30.100
set service dns forwarding listen-on eth5.30

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
set interfaces ethernet eth0 firewall in name WAN_IN
set interfaces ethernet eth0 firewall local name WAN_IN

set firewall name PROTECT_IN default-action accept
set firewall name PROTECT_IN rule 1 action drop
set firewall name PROTECT_IN rule 1 description 'Drop new connections from WLAN to LAN'
set firewall name PROTECT_IN rule 1 destination address 10.10.0.0/16
set firewall name PROTECT_IN rule 1 state new enable
set firewall name PROTECT_IN rule 1 protocol all
set firewall name PROTECT_IN rule 2 action drop
set firewall name PROTECT_IN rule 2 description 'Drop new connections from WLAN to WANs LAN'
set firewall name PROTECT_IN rule 2 destination address 192.168.0.0/16
set firewall name PROTECT_IN rule 2 state new enable
set firewall name PROTECT_IN rule 2 protocol all
set interfaces ethernet eth5 vif 20 firewall in name PROTECT_IN

set firewall name PROTECT_LOCAL default-action drop
set firewall name PROTECT_LOCAL rule 1 action accept
set firewall name PROTECT_LOCAL rule 1 description 'Allow DNS'
set firewall name PROTECT_LOCAL rule 1 destination port 53
set firewall name PROTECT_LOCAL rule 1 protocol udp
set firewall name PROTECT_LOCAL rule 2 action accept
set firewall name PROTECT_LOCAL rule 2 description 'Accept DHCP'
set firewall name PROTECT_LOCAL rule 2 destination port 67
set firewall name PROTECT_LOCAL rule 2 protocol udp
set interfaces ethernet eth5 vif 20 firewall local name PROTECT_LOCAL

set service gui listen-address 10.10.50.1
set service ssh listen-address 10.10.50.1

commit
save
exit
