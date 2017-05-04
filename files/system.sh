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

commit
save
exit
