#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure

delete interfaces ethernet eth0 address
set interfaces ethernet eth0 description 'WAN'
set interfaces ethernet eth0 address dhcp
set interfaces ethernet eth0 mac AA:AA:AA:AA:AA:AA
set service dhcp-server global-parameters "send host-name &quot;VFHXXXXXXXXXX/XXXXXXXXX&quot;;"

delete interfaces ethernet eth1 address
set interfaces ethernet eth1 description 'TRUNK'
set interfaces ethernet eth1 address 10.10.30.100/32

delete interfaces ethernet eth1 vif 10 address
set interfaces ethernet eth1 vif 10 description 'LAN'
set interfaces ethernet eth1 vif 10 address 10.10.10.1/24

delete interfaces ethernet eth1 vif 20 address
set interfaces ethernet eth1 vif 20 description 'WLAN'
set interfaces ethernet eth1 vif 20 address 10.10.20.1/24

delete interfaces ethernet eth1 vif 30 address
set interfaces ethernet eth1 vif 30 description 'MANAGEMENT'
set interfaces ethernet eth1 vif 30 address 10.10.30.1/24

set interfaces ethernet eth0 mtu 1500
set interfaces ethernet eth1 mtu 1500
set interfaces ethernet eth1 vif 10 mtu 1500
set interfaces ethernet eth1 vif 20 mtu 1500
set interfaces ethernet eth1 vif 30 mtu 1500

commit
save
exit
