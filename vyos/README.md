# erx-sfp
Configuration files for Vyos

## How send dhcp params (hack)

```
sudo su
nano /var/lib/dhcp3/dhclient_eth0.conf
```
Replace X for proper values:
```
interface "eth0" {
        send host-name "VFHXXXXXXXXXX/XXXXXXXXX"
        request subnet-mask, broadcast-address, routers, domain-name-servers, domain-name, interface-mtu;
}
```

## Links
- http://140.120.7.21/LinuxRef/CephAndVirtualStorage/vyatta-gateway.html
- http://soucy.org/vyos/UsingVyOSasaFirewall.pdf
- https://wiki.vyos.net/wiki/User_Guide
- https://www.sonoracomm.com/internet/19-inet-support/233-vyatta-cable
