#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

set system conntrack modules ftp disable
set system conntrack modules gre disable
set system conntrack modules h323 disable
set system conntrack modules pptp disable
set system conntrack modules sip disable
set system conntrack modules tftp disable
set system conntrack timeout tcp close 10
set system conntrack timeout tcp close-wait 10
set system conntrack timeout tcp established 86400
set system conntrack timeout tcp fin-wait 10
set system conntrack timeout tcp last-ack 10
set system conntrack timeout tcp syn-recv 5
set system conntrack timeout tcp syn-sent 5
set system conntrack timeout tcp time-wait 10
set system conntrack timeout udp other 30
set system conntrack timeout udp stream 180
set system host-name bastionx86
set system name-server 8.8.4.4
set system name-server 8.8.8.8
set system syslog host 10.10.10.12 facility local3 level info
set system time-zone Europe/Madrid


delete interfaces ethernet eth0 address
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description WAN
set interfaces ethernet eth0 mac AA:AA:AA:AA:AA:AA
set service dhcp-server global-parameters "send host-name &quot;VFHXXXXXXXXXX/XXXXXXXXX&quot;;"

delete interfaces ethernet eth2 address
set interfaces ethernet eth2 address 10.10.60.1/24
set interfaces ethernet eth2 description 'MANAGEMENT'

delete interfaces ethernet eth1 address
set interfaces ethernet eth1 description 'TRUNK'

delete interfaces ethernet eth1 vif 10 address
set interfaces ethernet eth1 vif 10 address 10.10.10.1/24
set interfaces ethernet eth1 vif 10 description 'LAN'

delete interfaces ethernet eth1 vif 20 address
set interfaces ethernet eth1 vif 20 address 10.10.20.1/24
set interfaces ethernet eth1 vif 20 description 'WLAN'

delete interfaces ethernet eth1 vif 30 address
set interfaces ethernet eth1 vif 30 address 10.10.30.1/24
set interfaces ethernet eth1 vif 30 description 'WLAN_MANAGEMENT'

set interfaces ethernet eth0 mtu 1500
set interfaces ethernet eth1 mtu 1500         
set interfaces ethernet eth2 mtu 1500
set interfaces ethernet eth1 mtu 1500
set interfaces ethernet eth1 vif 10 mtu 1500
set interfaces ethernet eth1 vif 20 mtu 1500
set interfaces ethernet eth1 vif 30 mtu 1500

set service dhcp-server shared-network-name MANAGEMENT description 'MANAGEMENT'
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.60.0/24 default-router 10.10.60.1
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.60.0/24 dns-server 8.8.8.8
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.60.0/24 dns-server 8.8.4.4
set service dhcp-server shared-network-name MANAGEMENT subnet 10.10.60.0/24 start 10.10.60.10 stop 10.10.60.100

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
set service snmp community vyos authorization rw
set service snmp trap-target 10.10.10.14
set service snmp contact "Contact"
set service snmp description "Vyos"
set service snmp location "Location"

set service ssh
set service ssh listen-address 10.10.10.1
set service ssh port 22

set nat source rule 1 description "Masquerade from LAN to eth0 WAN"
set nat source rule 1 outbound-interface eth0
set nat source rule 1 source address 10.10.0.0/16
set nat source rule 1 translation address masquerade

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
set firewall name PROTECT_IN rule 2 description 'Drop new connections from WLAN to WAN'
set firewall name PROTECT_IN rule 2 destination address 192.168.0.0/16
set firewall name PROTECT_IN rule 2 state new enable
set firewall name PROTECT_IN rule 2 protocol all

set firewall name PROTECT_LOCAL default-action drop
set firewall name PROTECT_LOCAL rule 1 action accept
set firewall name PROTECT_LOCAL rule 1 description 'Allow DNS'
set firewall name PROTECT_LOCAL rule 1 destination port 53
set firewall name PROTECT_LOCAL rule 1 protocol udp
set firewall name PROTECT_LOCAL rule 2 action accept
set firewall name PROTECT_LOCAL rule 2 description 'Accept DHCP'
set firewall name PROTECT_LOCAL rule 2 destination port 67
set firewall name PROTECT_LOCAL rule 2 protocol udp
set firewall name PROTECT_LOCAL rule 3 action accept
set firewall name PROTECT_LOCAL rule 3 description 'Accept SNMP'
set firewall name PROTECT_LOCAL rule 3 destination port 161
set firewall name PROTECT_LOCAL rule 3 protocol udp

set interfaces ethernet eth0 firewall in name WAN_IN
set interfaces ethernet eth0 firewall local name WAN_IN
set interfaces ethernet eth5 vif 20 firewall in name PROTECT_IN
set interfaces ethernet eth5 vif 20 firewall local name PROTECT_LOCAL

commit
save
exit
