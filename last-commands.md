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

