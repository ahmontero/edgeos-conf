#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

delete interfaces ethernet eth0 address
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 description WAN
set interfaces ethernet eth0 mac AA:AA:AA:AA:AA:AA
set interfaces ethernet eth0 dhcp-options client-option "send host-name &quot;VFHXXXXXXXXXX/XXXXXXXXX&quot;;"

delete interfaces ethernet eth4 address
set interfaces ethernet eth4 address 10.10.50.1/24
set interfaces ethernet eth4 description 'ERX_MANAGEMENT'

delete interfaces ethernet eth5 address
set interfaces ethernet eth5 description 'TRUNK'

delete interfaces ethernet eth5 vif 10 address
set interfaces ethernet eth5 vif 10 address 10.10.10.1/24
set interfaces ethernet eth5 vif 10 description 'LAN'

delete interfaces ethernet eth5 vif 20 address
set interfaces ethernet eth5 vif 20 address 10.10.20.1/24
set interfaces ethernet eth5 vif 20 description 'WLAN'

delete interfaces ethernet eth5 vif 30 address
set interfaces ethernet eth5 vif 30 address 10.10.30.1/24
set interfaces ethernet eth5 vif 30 description 'WLAN_MANAGEMENT'

set interfaces ethernet eth0 mtu 1500
set interfaces ethernet eth1 mtu 1500
set interfaces ethernet eth2 mtu 1500
set interfaces ethernet eth3 mtu 1500
set interfaces ethernet eth4 mtu 1500
set interfaces ethernet eth5 mtu 1500
set interfaces ethernet eth5 vif 10 mtu 1500
set interfaces ethernet eth5 vif 20 mtu 1500
set interfaces ethernet eth5 vif 30 mtu 1500

commit
save
exit
