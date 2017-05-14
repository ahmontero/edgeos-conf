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
set system syslog host 10.10.10.14 facility all level info
set system time-zone Europe/Madrid

commit
save
exit
