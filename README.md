# erx-sfp
Configuration files to set TC7200 in bridge mode and use EdgeRouter as main router.
Validated for these versions:
```
EdgeRouter firmware version: 1.9.1
TC7200 firmware version: STEB.80.15
```

## How to configure bridge mode in cable modem Technicolor TC7200 (Vodafone Ono ES)
```
git@github.com:ahmontero/erx-sfp.git
cd erx-sfp
pip install -r requirements.txt
python vfh.py 192.168.0.1
```
1. Annotate the output of the command
2. Check your monthly bill and get your client number. It is a 9 digit number. 

Your hostname is something like:
```
{vfh_from_command}/{client_number}
```
You can send this hostname as a dhcp client option, so you do not need to change 
your router hostname to a not valid string.
```
set interfaces ethernet eth0 dhcp-options client-option "send host-name &quot;VFHXXXXXXXXXX/XXXXXXXXX&quot;;"
```

Example:
```
set interfaces ethernet eth0 dhcp-options client-option "send host-name &quot;VFH0123456789/012345678&quot;;" 
```

Now you need to configure bridge mode in modem router. 
```
1. Unplug EdgeRouter from modem cable
2. Plug your laptop to any port in cable modem
3. Login into cable modem: 192.168.0.1 vodafone/vodafone
4. Set Expert mode. 
5. Configuration -> Bridge Mode -> Select Disable
6. Reboot modem cable and wait until all lights are on
7. Connect EdgeRouter to Lan Port 1 in modem cable
```

Sometimes you need to wait a few minutes to get an external ip from the ISP. If you can not get the correct ip after 
few minutes, you can refresh ip from EdgeRouter or reboot it.

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
