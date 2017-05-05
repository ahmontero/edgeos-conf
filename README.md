# erx-sfp
Configuration files for EdgeRouter

## EdgeOS tips
How to use operational model in scripts:
```
#!/bin/bash
run=/opt/vyatta/bin/vyatta-op-cmd-wrapper
.
$run show version
.
```
How to use configuration mode in scripts:
```
#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure
.
.
.
commit
save
exit
```

## Update firmware
```
add system image https://dl.ubnt.com/firmwares/edgemax/v1.9.1.1/ER-e50.v1.9.1.1.4977602.tar
show system image storage
reboot
```

## Change user
```
delete system login user ubnt
set system login user ubnt authentication plaintext-password 'password'
```

## Activate POE
```
set interfaces ethernet eth4 poe output 24v
```

## Links
- https://community.brocade.com/dtscp75322/attachments/dtscp75322/Certification/30/3/Vyatta-BasicSystem_6.6R1_v01.pdf
- https://community.brocade.com/dtscp75322/attachments/dtscp75322/SoftwareNetworking/14/1/Vyatta_Firewall_Best_Practices.pdf
- https://community.ubnt.com/t5/EdgeMAX/Best-Practices-Guide-Vyatta-Firewall-by-Brocade-Community/td-p/706027
- https://community.ubnt.com/t5/EdgeMAX/Help-with-firewall-rules/td-p/1021431
- https://community.ubnt.com/t5/EdgeMAX/What-is-WAN-IN-vs-WAN-LOCAL/td-p/1098853
- https://www.cron.dk/edgerouter-security-part1/
- https://www.manitonetworks.com/ubiquiti/
- https://www.sans.org/reading-room/whitepapers/firewalls/deploying-vyatta-core-firewall-33493
