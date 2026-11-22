2026-11-21 16:47 MSK

```
ndrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ sudo nmcli con up failsafe
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/13)
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ ip addr show enp7s0 | grep inet
    inet 192.168.1.10/24 brd 192.168.1.255 scope global noprefixroute enp7s0
    inet6 fe80::1e75:8ff:fe61:1751/64 scope link 
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ telnet 192.168.1.1
Trying 192.168.1.1...
telnet: Unable to connect to remote host: No route to host
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ ssh root@192.168.1.1
ssh: connect to host 192.168.1.1 port 22: No route to host
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
From 192.168.1.10 icmp_seq=1 Destination Host Unreachable
From 192.168.1.10 icmp_seq=2 Destination Host Unreachable
From 192.168.1.10 icmp_seq=3 Destination Host Unreachable
From 192.168.1.10 icmp_seq=4 Destination Host Unreachable
From 192.168.1.10 icmp_seq=5 Destination Host Unreachable
From 192.168.1.10 icmp_seq=6 Destination Host Unreachable
^C
--- 192.168.1.1 ping statistics ---
8 packets transmitted, 0 received, +6 errors, 100% packet loss, time 7160ms
pipe 4
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ nc 192.168.1.1 23
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ sudo nmcli con down failsafe
Connection 'failsafe' successfully deactivated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/13)
andrej@lenovo-Ideapad-Z560:~/work/xiaomi-openwrt-restore$ 

```

2026-11-22 05:52 MSK

05:53 (approx):
sudo dnsmasq --conf-file=/home/andrej/work/xiaomi-openwrt-restore/reflash/dnsmasq-recovery-$(date +%Y%m%d-%H%M%S).conf  --no-daemon

05:55 (approx):
sudo tcpdump -i enp7s0 -n -e -l  'arp or udp port 67 or udp port 68 or udp port 69' > /home/andrej/work/xiaomi-openwrt-restore/reflash/recovery-tftp-$(date +%Y%m%d-%H%M%S).txt 2>&1

router is still blinking pink, as it was its last state for last hours

05:57
Will attempt a reboot
power off - 10-20 seconds wait - power on
observation: led permanent orange

06:03
wanted to power off an power on holding reset button - was not holding it properly
observation: permanent orange led

06:07
will attempt a reboot with reset button
observation: led permanent orange, for approx 5 seconds - orange blinking, for several more seconds - permament orange, for like 10 seconds - pink blinking

2026-11-22 06:27 MSK

Attempted recovery again, this time applying the ARP pre-seed first (cleanup + pre-seed + one dnsmasq + tcpdump + power-cycle).

```
sudo pkill -f 'dnsmasq --conf-file=.*dnsmasq-recovery'
sudo pkill -f 'tcpdump -i enp7s0'
sudo ip neigh flush dev enp7s0
sudo ip addr flush dev enp7s0
sudo ip addr add 192.168.31.100/24 dev enp7s0
sudo ip link set enp7s0 up
sudo ip neigh replace 192.168.31.1 lladdr 82:73:78:2e:b6:69 nud permanent dev enp7s0
sudo dnsmasq --conf-file=/home/andrej/work/xiaomi-openwrt-restore/reflash/dnsmasq-recovery.conf --no-daemon
sudo tcpdump -i enp7s0 -n -e -l 'arp or udp port 67 or udp port 68 or udp port 69'
```

tcpdump result: DHCP DISCOVER/OFFER ok -> router ARP `who-has 192.168.31.100` (host replies) -> TFTP RRQ "test.bin" -> host sends **unicast** ARP probe `who-has 192.168.31.1 -> 82:73:78:2e:b6:69` (x3, no reply) -> **NO TFTP DATA**. Still stalls.

`ip neigh show dev enp7s0` -> `192.168.31.1 FAILED`  (pre-seed did NOT hold; not PERMANENT)

=> initramfs did NOT boot. Need to re-apply the ARP entry with `ip neigh del` + `ip neigh add ... nud permanent` and VERIFY `ip neigh show` prints PERMANENT before power-cycling.




