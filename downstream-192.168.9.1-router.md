> **NOTE (2026-11-22):** this is a read-only transcript captured against the main/working
> router when its LAN was still `192.168.1.1`. The router has since been **renumbered to
> `192.168.9.x`** (router = `192.168.9.1`, DHCP pool `192.168.9.0/24`) to avoid clashing with
> OpenWrt failsafe/initramfs at `192.168.1.1`. All `192.168.1.x` addresses below are the
> pre-renumber state and are historical only.


```
BusyBox v1.36.1 (2023-11-14 13:38:11 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt 23.05.2, r23630-842932a63d
 -----------------------------------------------------
root@OpenWrt:~# uname -a
Linux OpenWrt 5.15.137 #0 SMP Tue Nov 14 13:38:11 2023 mips GNU/Linux
root@OpenWrt:~# opkg
opkg must have one sub-command argument
usage: opkg [options...] sub-command [arguments...]
where sub-command is one of:

Package Manipulation:
	update			Update list of available packages
	upgrade <pkgs>		Upgrade packages
	install <pkgs>		Install package(s)
	configure <pkgs>	Configure unpacked package(s)
	remove <pkgs|regexp>	Remove package(s)
	flag <flag> <pkgs>	Flag package(s)
	 <flag>=hold|noprune|user|ok|installed|unpacked (one per invocation)

Informational Commands:
	list			List available packages
	list-installed		List installed packages
	list-upgradable		List installed and upgradable packages
	list-changed-conffiles	List user modified configuration files
	files <pkg>		List files belonging to <pkg>
	search <file|regexp>	List package providing <file>
	find <regexp>		List packages whose name or description matches <regexp>
	info [pkg|regexp]	Display all info for <pkg>
	status [pkg|regexp]	Display all status for <pkg>
	download <pkg>		Download <pkg> to current directory
	compare-versions <v1> <op> <v2>
	                    compare versions using <= < > >= = << >>
	print-architecture	List installable package architectures
	depends [-A] [pkgname|pat]+
	whatdepends [-A] [pkgname|pat]+
	whatdependsrec [-A] [pkgname|pat]+
	whatrecommends[-A] [pkgname|pat]+
	whatsuggests[-A] [pkgname|pat]+
	whatprovides [-A] [pkgname|pat]+
	whatconflicts [-A] [pkgname|pat]+
	whatreplaces [-A] [pkgname|pat]+

Options:
	-A			Query all packages not just those installed
	-V[<level>]		Set verbosity level to <level>.
	--verbosity[=<level>]	Verbosity levels:
					0 errors only
					1 normal messages (default)
					2 informative messages
					3 debug
					4 debug level 2
	-f <conf_file>		Use <conf_file> as the opkg configuration file
	--conf <conf_file>
	--cache <directory>	Use a package cache
	-d <dest_name>		Use <dest_name> as the the root directory for
	--dest <dest_name>	package installation, removal, upgrading.
				<dest_name> should be a defined dest name from
				the configuration file, (but can also be a
				directory name in a pinch).
	-o <dir>		Use <dir> as the root directory for
	--offline-root <dir>	offline installation of packages.
	--verify-program <path>	Use the given program to verify usign signatures
	--add-arch <arch>:<prio>	Register architecture with given priority
	--add-dest <name>:<path>	Register destination with given path

Force Options:
	--force-depends		Install/remove despite failed dependencies
	--force-maintainer	Overwrite preexisting config files
	--force-reinstall	Reinstall package(s)
	--force-overwrite	Overwrite files from other package(s)
	--force-downgrade	Allow opkg to downgrade packages
	--force-space		Disable free space checks
	--force-postinstall	Run postinstall scripts even in offline mode
	--force-remove	Remove package even if prerm script fails
	--force-checksum	Don't fail on checksum mismatches
	--no-check-certificate Don't validate SSL certificates
	--noaction		No action -- test only
	--download-only	No action -- download only
	--nodeps		Do not follow dependencies
	--nocase		Perform case insensitive pattern matching
	--size			Print package size when listing available packages
	--strip-abi		Print package name without appended ABI version
	--force-removal-of-dependent-packages
				Remove package and all dependencies
	--autoremove		Remove packages that were installed
				automatically to satisfy dependencies
	-t			Specify tmp-dir.
	--tmp-dir		Specify tmp-dir.
	-l			Specify lists-dir.
	--lists-dir		Specify lists-dir.

 regexp could be something like 'pkgname*' '*file*' or similar
 e.g. opkg info 'libstd*' or opkg search '*libop*' or opkg remove 'libncur*'
root@OpenWrt:~# useradd
Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
      --badnames                do not check for bad names
  -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
      --btrfs-subvolume-home    use BTRFS subvolume for home directory
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user

root@OpenWrt:~# usermod
Usage: usermod [options] LOGIN

Options:
  -b, --badnames                allow bad names
  -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                the user from other groups
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -R, --root CHROOT_DIR         directory to chroot into
  -P, --prefix PREFIX_DIR       prefix directory where are located the /etc/* files
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids

root@OpenWrt:~# groupadd
-ash: groupadd: not found
root@OpenWrt:~# useradd -M -N -s /bin/ash netadmin-agent-01
root@OpenWrt:~# passwd netadmin-agent-01
Changing password for netadmin-agent-01
New password: 
Retype password: 
passwd: password for netadmin-agent-01 changed by root
root@OpenWrt:~# echo 'passwd=freedom2agents'
passwd=freedom2agents
root@OpenWrt:~# id netadmin-agent-01
uid=1001(netadmin-agent-01) gid=100(users) groups=100(users)
root@OpenWrt:~# opkg update
Downloading https://downloads.openwrt.org/releases/23.05.2/targets/ramips/mt7621/packages/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_core
Downloading https://downloads.openwrt.org/releases/23.05.2/targets/ramips/mt7621/packages/Packages.sig
Signature check passed.
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/base/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_base
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/base/Packages.sig
Signature check passed.
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/luci/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_luci
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/luci/Packages.sig
Signature check passed.
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/packages/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_packages
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/packages/Packages.sig
Signature check passed.
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/routing/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_routing
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/routing/Packages.sig
Signature check passed.
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/telephony/Packages.gz
Updated list of available packages in /var/opkg-lists/openwrt_telephony
Downloading https://downloads.openwrt.org/releases/23.05.2/packages/mipsel_24kc/telephony/Packages.sig
Signature check passed.
root@OpenWrt:~# opkg install sudo
Package sudo (1.9.17p1-1) installed in root is up to date.
root@OpenWrt:~# which sudo
/usr/bin/sudo
root@OpenWrt:~# which visudo
/usr/sbin/visudo
root@OpenWrt:~# ls -la /usr/sbin | grep netadmin
root@OpenWrt:~# cat > /usr/sbin/netadmin <<'EOF'
> #!/bin/ash
> 
> case "$1" in
>     status)
>         echo "=== Interfaces ==="
>         ip addr
>         echo "=== Routes ==="
>         ip route
>         echo "=== Network status ==="
>         ubus call network.interface dump
>         ;;
> 
>     logs)
>         logread
>         ;;
> 
>     network-config)
>         cat /etc/config/network
>         ;;
> 
>     restart-network)
>         /etc/init.d/network restart
>         ;;
> 
>     reload-network)
>         /etc/init.d/network reload
>         ;;
> 
>     *)
>         echo "Usage: netadmin {status|logs|network-config|restart-network|reload-network}"
>         exit 1
>         ;;
> esac
> EOF
root@OpenWrt:~# 
root@OpenWrt:~# chmod 755 /usr/sbin/netadmin
root@OpenWrt:~# chown root:root /usr/sbin/netadmin
root@OpenWrt:~# visudo
root@OpenWrt:~# tail /etc/sudoers
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL:ALL) ALL  # WARNING: only use this together with 'Defaults targetpw'

## Read drop-in files from /etc/sudoers.d
@includedir /etc/sudoers.d

netadmin-agent-01 ALL=(root) NOPASSWD: /usr/sbin/netadmin


root@OpenWrt:~# visudo -c
/etc/sudoers: parsed OK
root@OpenWrt:~# exit
Connection to 192.168.1.1 closed.
andrej@mbhome ~ % ssh netadmin-agent-01@192.168.1.1
** WARNING: connection is not using a post-quantum key exchange algorithm.
** This session may be vulnerable to "store now, decrypt later" attacks.
** The server may need to be upgraded. See https://openssh.com/pq.html
netadmin-agent-01@192.168.1.1's password: 
Failed chdir '/home/netadmin-agent-01': No such file or directory


BusyBox v1.36.1 (2023-11-14 13:38:11 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt 23.05.2, r23630-842932a63d
 -----------------------------------------------------
netadmin-agent-01@OpenWrt:/$ sudo -l
Matching Defaults entries for netadmin-agent-01 on OpenWrt:
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin

Runas and Command-specific defaults for netadmin-agent-01:
    Defaults!/usr/sbin/visudo env_keep+="SUDO_EDITOR EDITOR VISUAL"

User netadmin-agent-01 may run the following commands on OpenWrt:
    (root) NOPASSWD: /usr/sbin/netadmin
netadmin-agent-01@OpenWrt:/$ sudo /usr/sbin/netadmin status
=== Interfaces ===
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1504 qdisc mq state UP qlen 1000
    link/ether 50:64:2b:e8:6c:bc brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5264:2bff:fee8:6cbc/64 scope link 
       valid_lft forever preferred_lft forever
3: wan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
    link/ether 50:64:2b:e8:6c:bd brd ff:ff:ff:ff:ff:ff
    inet 100.125.131.245/17 brd 100.125.255.255 scope global wan
       valid_lft forever preferred_lft forever
    inet6 fe80::5264:2bff:fee8:6cbd/64 scope link 
       valid_lft forever preferred_lft forever
4: lan2@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-lan state UP qlen 1000
    link/ether 50:64:2b:e8:6c:bc brd ff:ff:ff:ff:ff:ff
5: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue master br-lan state LOWERLAYERDOWN qlen 1000
    link/ether 50:64:2b:e8:6c:bc brd ff:ff:ff:ff:ff:ff
8: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP qlen 1000
    link/ether 50:64:2b:e8:6c:bc brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.1/24 brd 192.168.1.255 scope global br-lan
       valid_lft forever preferred_lft forever
    inet6 fd2f:4f50:80be::1/60 scope global noprefixroute 
       valid_lft forever preferred_lft forever
    inet6 fe80::5264:2bff:fee8:6cbc/64 scope link 
       valid_lft forever preferred_lft forever
9: phy1-ap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-lan state UP qlen 1000
    link/ether 50:64:2b:e8:6c:bf brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5264:2bff:fee8:6cbf/64 scope link 
       valid_lft forever preferred_lft forever
10: phy0-ap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-lan state UP qlen 1000
    link/ether 50:64:2b:e8:6c:be brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5264:2bff:fee8:6cbe/64 scope link 
       valid_lft forever preferred_lft forever
=== Routes ===
default via 100.125.128.1 dev wan  src 100.125.131.245 
100.125.128.0/17 dev wan scope link  src 100.125.131.245 
192.168.1.0/24 dev br-lan scope link  src 192.168.1.1 
=== Network status ===
{
	"interface": [
		{
			"interface": "lan",
			"up": true,
			"pending": false,
			"available": true,
			"autostart": true,
			"dynamic": false,
			"uptime": 1570307,
			"l3_device": "br-lan",
			"proto": "static",
			"device": "br-lan",
			"updated": [
				"addresses"
			],
			"metric": 0,
			"dns_metric": 0,
			"delegation": true,
			"ipv4-address": [
				{
					"address": "192.168.1.1",
					"mask": 24
				}
			],
			"ipv6-address": [
				
			],
			"ipv6-prefix": [
				
			],
			"ipv6-prefix-assignment": [
				{
					"address": "fd2f:4f50:80be::",
					"mask": 60,
					"local-address": {
						"address": "fd2f:4f50:80be::1",
						"mask": 60
					}
				}
			],
			"route": [
				
			],
			"dns-server": [
				
			],
			"dns-search": [
				
			],
			"neighbors": [
				
			],
			"inactive": {
				"ipv4-address": [
					
				],
				"ipv6-address": [
					
				],
				"route": [
					
				],
				"dns-server": [
					
				],
				"dns-search": [
					
				],
				"neighbors": [
					
				]
			},
			"data": {
				
			}
		},
		{
			"interface": "loopback",
			"up": true,
			"pending": false,
			"available": true,
			"autostart": true,
			"dynamic": false,
			"uptime": 1570307,
			"l3_device": "lo",
			"proto": "static",
			"device": "lo",
			"updated": [
				"addresses"
			],
			"metric": 0,
			"dns_metric": 0,
			"delegation": true,
			"ipv4-address": [
				{
					"address": "127.0.0.1",
					"mask": 8
				}
			],
			"ipv6-address": [
				
			],
			"ipv6-prefix": [
				
			],
			"ipv6-prefix-assignment": [
				
			],
			"route": [
				
			],
			"dns-server": [
				
			],
			"dns-search": [
				
			],
			"neighbors": [
				
			],
			"inactive": {
				"ipv4-address": [
					
				],
				"ipv6-address": [
					
				],
				"route": [
					
				],
				"dns-server": [
					
				],
				"dns-search": [
					
				],
				"neighbors": [
					
				]
			},
			"data": {
				
			}
		},
		{
			"interface": "wan",
			"up": true,
			"pending": false,
			"available": true,
			"autostart": true,
			"dynamic": false,
			"uptime": 2307,
			"l3_device": "wan",
			"proto": "dhcp",
			"device": "wan",
			"metric": 0,
			"dns_metric": 0,
			"delegation": true,
			"ipv4-address": [
				{
					"address": "100.125.131.245",
					"mask": 17
				}
			],
			"ipv6-address": [
				
			],
			"ipv6-prefix": [
				
			],
			"ipv6-prefix-assignment": [
				
			],
			"route": [
				{
					"target": "0.0.0.0",
					"mask": 0,
					"nexthop": "100.125.128.1",
					"source": "100.125.131.245/32"
				}
			],
			"dns-server": [
				"8.8.8.8",
				"8.8.4.4"
			],
			"dns-search": [
				
			],
			"neighbors": [
				
			],
			"inactive": {
				"ipv4-address": [
					
				],
				"ipv6-address": [
					
				],
				"route": [
					
				],
				"dns-server": [
					"185.44.8.51",
					"185.44.8.53"
				],
				"dns-search": [
					
				],
				"neighbors": [
					
				]
			},
			"data": {
				"dhcpserver": "100.125.128.1",
				"leasetime": 3600
			}
		},
		{
			"interface": "wan6",
			"up": false,
			"pending": true,
			"available": true,
			"autostart": true,
			"dynamic": false,
			"proto": "dhcpv6",
			"device": "wan",
			"data": {
				
			}
		}
	]
}
netadmin-agent-01@OpenWrt:/$ sudo /usr/sbin/netadmin network-config

config interface 'loopback'
	option device 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'
	option ula_prefix 'fd2f:4f50:80be::/48'
	option packet_steering '1'

config device
	option name 'br-lan'
	option type 'bridge'
	list ports 'lan1'
	list ports 'lan2'

config interface 'lan'
	option device 'br-lan'
	option proto 'static'
	option ipaddr '192.168.1.1'
	option netmask '255.255.255.0'
	option ip6assign '60'

config interface 'wan'
	option device 'wan'
	option proto 'dhcp'
	option peerdns '0'
	list dns '8.8.8.8'
	list dns '8.8.4.4'

config interface 'wan6'
	option device 'wan'
	option proto 'dhcpv6'

netadmin-agent-01@OpenWrt:/$ ls -la /usr/sbin/ | grep netadmin
-rwxr-xr-x    1 root     root           592 Nov 21 11:39 netadmin
netadmin-agent-01@OpenWrt:/$ sudo /usr/sbin/netadmin logs
Fri Nov 20 15:01:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:01:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:01:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:01:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:01:55 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:02:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.102 26:7f:31:e7:6b:26
Fri Nov 20 15:02:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.102 26:7f:31:e7:6b:26 Andrey-Samsung
Fri Nov 20 15:04:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:08:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:12:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:18:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:18:48 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:18:48 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:18:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:19:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 15:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 15:26:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:29:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:29:30 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:29:30 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:29:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:29:30 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:29:30 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:29:32 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:29:32 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:29:35 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:30:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:36:22 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:43:55 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:44:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:44:57 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 15:44:57 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 15:44:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:53:13 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 15:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 15:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 16:01:05 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:02:25 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:02:25 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 16:02:25 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 16:02:25 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:02:29 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:04:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:05:14 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.130 78:9a:18:d7:44:93
Fri Nov 20 16:05:14 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.130 78:9a:18:d7:44:93 MikroTik
Fri Nov 20 16:10:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:10:53 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 16:10:53 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 16:10:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:10:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:11:02 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:11:16 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:19:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 16:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 16:26:54 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:28:17 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 16:28:17 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 16:28:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:28:21 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:33:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:42:29 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:45:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:45:34 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 16:45:34 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 16:45:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:49:16 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 16:56:32 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 16:56:32 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 16:58:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:02:44 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:02:44 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:02:44 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:02:44 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:02:44 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:02:44 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:02:46 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:02:46 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:04:16 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:11:18 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:18:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:20:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:20:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:20:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:20:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:20:43 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:23:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:26:32 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 17:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 17:33:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:35:45 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:35:45 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:35:45 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:35:45 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:40:35 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe
Fri Nov 20 17:40:35 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe Xiaomi-13T-Pro
Fri Nov 20 17:42:36 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:49:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:52:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:52:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 17:52:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 17:52:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:52:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:56:01 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 17:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 17:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 18:00:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:06:15 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:07:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:07:57 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 18:07:57 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 18:07:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:12:01 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:12:23 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:12:23 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 18:12:23 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 18:12:23 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:12:28 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:17:31 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:23:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 18:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 18:28:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:28:33 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 18:28:33 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 18:28:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:28:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:28:42 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:30:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:37:50 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:43:06 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:47:36 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:54:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 18:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 18:59:21 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 18:59:21 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 18:59:21 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 18:59:26 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:04:16 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:09:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:09:14 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:09:14 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:09:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:09:18 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:11:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:11:24 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:11:24 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:11:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:11:29 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:13:15 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:20:28 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 19:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 19:26:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:26:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:26:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:26:42 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:26:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:26:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:26:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:26:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:28:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:32:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:37:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:37:59 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:37:59 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:37:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:37:59 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:37:59 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:38:01 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 19:38:01 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 19:38:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:38:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:41:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:45:05 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:54:20 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 19:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 19:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 20:02:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:08:48 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 20:08:48 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 20:08:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:08:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:08:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:09:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:14:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:23:10 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 20:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 20:32:22 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:36:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:38:15 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 20:38:15 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 20:38:15 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:38:15 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 20:38:15 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 20:38:17 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Fri Nov 20 20:38:17 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Fri Nov 20 20:38:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:38:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:40:12 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:49:31 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 20:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 20:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 20:58:47 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:02:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.102 26:7f:31:e7:6b:26
Fri Nov 20 21:02:43 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.102 26:7f:31:e7:6b:26 Andrey-Samsung
Fri Nov 20 21:06:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:11:11 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:21:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 21:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 21:28:29 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:34:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:39:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:40:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.130 78:9a:18:d7:44:93
Fri Nov 20 21:40:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.130 78:9a:18:d7:44:93 MikroTik
Fri Nov 20 21:47:02 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:55:28 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 21:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 21:56:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 22:03:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:12:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:17:56 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:24:44 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 22:26:33 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 22:30:15 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:40:07 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:44:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:53:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 22:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 22:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 23:01:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:06:10 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:13:01 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:21:45 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 23:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Fri Nov 20 23:28:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:35:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:40:35 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe
Fri Nov 20 23:40:35 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe Xiaomi-13T-Pro
Fri Nov 20 23:43:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:47:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:54:20 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Fri Nov 20 23:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Fri Nov 20 23:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 00:02:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:06:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:11:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:16:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:20:27 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 00:26:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 00:30:23 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:34:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:39:35 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:43:32 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:48:13 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 00:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 00:56:34 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 00:57:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:04:05 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:10:13 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:16:50 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 01:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 01:26:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:33:07 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:39:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:44:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:51:50 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 01:56:35 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 01:56:35 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 02:01:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:07:20 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:15:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:24:31 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 02:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 02:30:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:38:16 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 02:38:16 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 02:38:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:48:18 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 02:56:35 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 02:56:35 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 02:56:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:00:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:02:45 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.102 26:7f:31:e7:6b:26
Sat Nov 21 03:02:45 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.102 26:7f:31:e7:6b:26 Andrey-Samsung
Sat Nov 21 03:06:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:14:41 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.130 78:9a:18:d7:44:93
Sat Nov 21 03:14:41 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.130 78:9a:18:d7:44:93 MikroTik
Sat Nov 21 03:15:08 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:20:44 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 03:26:35 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 03:27:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:32:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:37:22 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:45:39 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:55:08 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 03:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 03:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 04:00:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:06:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:11:55 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:17:29 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:25:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:26:36 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 04:26:36 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 04:32:36 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:37:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:42:07 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:47:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:51:43 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:54:53 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 04:54:53 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 04:54:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:54:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:55:02 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 04:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 04:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 05:01:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:09:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:12:09 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 05:12:09 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 05:12:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:19:48 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:23:25 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:23:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:23:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 05:23:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:23:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 05:23:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 05:23:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 05:23:55 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:23:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 05:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 05:32:56 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:37:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:40:36 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe
Sat Nov 21 05:40:36 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe Xiaomi-13T-Pro
Sat Nov 21 05:44:25 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:52:38 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 05:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 05:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 06:00:56 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:10:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:14:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:16:32 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 IEEE 802.11: associated (aid 1)
Sat Nov 21 06:16:32 2026 daemon.notice hostapd: phy0-ap0: AP-STA-CONNECTED 1c:65:9d:cf:2f:23 auth_alg=sae
Sat Nov 21 06:16:32 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 WPA: pairwise key handshake completed (RSN)
Sat Nov 21 06:16:32 2026 daemon.notice hostapd: phy0-ap0: EAPOL-4WAY-HS-COMPLETED 1c:65:9d:cf:2f:23
Sat Nov 21 06:16:32 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 06:16:32 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23 lenovo-Ideapad-Z560
Sat Nov 21 06:16:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:16:34 2026 daemon.info dnsmasq[1]: read /etc/hosts - 12 names
Sat Nov 21 06:16:34 2026 daemon.info dnsmasq[1]: read /tmp/hosts/dhcp.cfg01411c - 6 names
Sat Nov 21 06:16:34 2026 daemon.info dnsmasq[1]: read /tmp/hosts/odhcpd - 2 names
Sat Nov 21 06:16:34 2026 daemon.info dnsmasq-dhcp[1]: read /etc/ethers - 0 addresses
Sat Nov 21 06:18:01 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 06:18:01 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 06:18:01 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:18:05 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:20:08 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:21:36 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:21:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 06:21:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:21:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 06:21:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:21:46 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:24:31 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:26:25 2026 authpriv.info dropbear[3563]: Child connection from 192.168.1.116:50180
Sat Nov 21 06:26:25 2026 authpriv.warn dropbear[3563]: Login attempt for nonexistent user
Sat Nov 21 06:26:31 2026 authpriv.info dropbear[3563]: Exit before auth from <192.168.1.116:50180>: Exited normally
Sat Nov 21 06:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 06:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 06:32:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:42:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:48:10 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:53:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 06:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 06:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 07:02:16 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:11:03 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:16:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:19:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:24:32 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 07:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 07:28:15 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:31:02 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 WPA: group key handshake completed (RSN)
Sat Nov 21 07:31:02 2026 daemon.info hostapd: phy1-ap0: STA 6a:8b:c3:64:be:aa WPA: group key handshake completed (RSN)
Sat Nov 21 07:31:02 2026 daemon.info hostapd: phy1-ap0: STA 3e:81:b4:fe:b8:fe WPA: group key handshake completed (RSN)
Sat Nov 21 07:31:03 2026 daemon.info hostapd: phy1-ap0: STA 26:7f:31:e7:6b:26 WPA: group key handshake completed (RSN)
Sat Nov 21 07:38:03 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:41:28 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:45:02 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:53:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 07:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 07:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 08:02:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:04:40 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 08:04:40 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 08:04:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:04:40 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 08:04:40 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 08:04:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 08:04:42 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 08:04:45 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:04:49 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:08:06 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:16:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:17:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:18:20 2026 daemon.notice hostapd: phy0-ap0: AP-STA-DISCONNECTED 1c:65:9d:cf:2f:23
Sat Nov 21 08:18:23 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 IEEE 802.11: associated (aid 1)
Sat Nov 21 08:18:23 2026 daemon.notice hostapd: phy0-ap0: AP-STA-CONNECTED 1c:65:9d:cf:2f:23 auth_alg=sae
Sat Nov 21 08:18:23 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 WPA: pairwise key handshake completed (RSN)
Sat Nov 21 08:18:23 2026 daemon.notice hostapd: phy0-ap0: EAPOL-4WAY-HS-COMPLETED 1c:65:9d:cf:2f:23
Sat Nov 21 08:18:23 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 08:18:23 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23 lenovo-Ideapad-Z560
Sat Nov 21 08:18:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:24:31 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 08:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 08:29:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:35:34 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:39:58 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:45:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:49:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.130 78:9a:18:d7:44:93
Sat Nov 21 08:49:39 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.130 78:9a:18:d7:44:93 MikroTik
Sat Nov 21 08:50:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 08:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 08:56:36 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 09:00:06 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:02:47 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.102 26:7f:31:e7:6b:26
Sat Nov 21 09:02:47 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.102 26:7f:31:e7:6b:26 Andrey-Samsung
Sat Nov 21 09:07:35 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:16:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:18:24 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:19:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 09:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 09:27:01 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:33:30 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:38:42 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:48:08 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 09:48:08 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 09:48:08 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:48:08 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 09:48:08 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 09:48:10 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 09:48:10 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 09:48:13 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:48:17 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:48:21 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:53:14 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 09:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 09:56:37 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 09:56:40 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:03:20 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:07:53 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:15:22 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:18:23 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:20:07 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:24:59 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:26:37 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 10:26:38 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 10:30:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:30:28 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 10:30:28 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 10:30:28 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:30:29 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 10:30:29 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 10:30:33 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:30:37 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:35:35 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:36:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 10:36:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 10:36:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:36:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 10:36:51 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 10:36:56 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:37:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:44:41 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:50:19 2026 kern.info kernel: [1567148.334996] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:50:19 2026 kern.info kernel: [1567148.341033] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:50:19 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:50:52 2026 kern.info kernel: [1567181.021470] mt7530-mdio mdio-bus:1f lan2: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Nov 21 10:50:52 2026 kern.info kernel: [1567181.029659] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:50:52 2026 kern.info kernel: [1567181.035132] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:50:52 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:50:57 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:50:57 2026 daemon.info dnsmasq[1]: read /etc/hosts - 12 names
Sat Nov 21 10:50:57 2026 daemon.info dnsmasq[1]: read /tmp/hosts/dhcp.cfg01411c - 6 names
Sat Nov 21 10:50:57 2026 daemon.info dnsmasq[1]: read /tmp/hosts/odhcpd - 4 names
Sat Nov 21 10:50:57 2026 daemon.info dnsmasq-dhcp[1]: read /etc/ethers - 0 addresses
Sat Nov 21 10:51:04 2026 daemon.info dnsmasq-dhcp[1]: DHCPDISCOVER(br-lan) 192.168.2.206 1c:75:08:61:17:51
Sat Nov 21 10:51:04 2026 daemon.info dnsmasq-dhcp[1]: DHCPOFFER(br-lan) 192.168.1.206 1c:75:08:61:17:51
Sat Nov 21 10:51:04 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.2.206 1c:75:08:61:17:51
Sat Nov 21 10:51:04 2026 daemon.info dnsmasq-dhcp[1]: DHCPNAK(br-lan) 192.168.2.206 1c:75:08:61:17:51 wrong server-ID
Sat Nov 21 10:52:33 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:52:33 2026 kern.info kernel: [1567281.552456] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:52:33 2026 kern.info kernel: [1567281.558265] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:52:42 2026 kern.info kernel: [1567291.137535] mt7530-mdio mdio-bus:1f lan2: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Nov 21 10:52:42 2026 kern.info kernel: [1567291.145724] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:52:42 2026 kern.info kernel: [1567291.151193] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:52:42 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:52:44 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:52:44 2026 kern.info kernel: [1567293.125139] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:52:44 2026 kern.info kernel: [1567293.130742] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:52:47 2026 kern.info kernel: [1567295.576335] mt7530-mdio mdio-bus:1f lan2: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Nov 21 10:52:47 2026 kern.info kernel: [1567295.584553] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:52:47 2026 kern.info kernel: [1567295.590030] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:52:47 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:52:49 2026 kern.info kernel: [1567297.656343] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:52:49 2026 kern.info kernel: [1567297.661838] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:52:49 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:53:01 2026 kern.info kernel: [1567309.939228] mt7530-mdio mdio-bus:1f lan2: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Nov 21 10:53:01 2026 kern.info kernel: [1567309.947472] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:53:01 2026 kern.info kernel: [1567309.952917] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:53:01 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:53:19 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:56:38 2026 daemon.notice netifd: wan (8371): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 10:56:38 2026 daemon.notice netifd: wan (8371): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 10:57:46 2026 kern.info kernel: [1567595.062272] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:57:46 2026 kern.info kernel: [1567595.068092] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:57:46 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:57:54 2026 kern.info kernel: [1567602.701279] mt7530-mdio mdio-bus:1f lan2: Link is Up - 1Gbps/Full - flow control rx/tx
Sat Nov 21 10:57:54 2026 kern.info kernel: [1567602.709428] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:57:54 2026 kern.info kernel: [1567602.714868] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:57:54 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:58:15 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 10:58:15 2026 kern.info kernel: [1567623.786614] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:58:15 2026 kern.info kernel: [1567623.792289] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:58:35 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 10:58:49 2026 kern.info kernel: [1567657.995941] mt7530-mdio mdio-bus:1f lan2: Link is Up - 100Mbps/Full - flow control rx/tx
Sat Nov 21 10:58:49 2026 kern.info kernel: [1567658.004332] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 10:58:49 2026 kern.info kernel: [1567658.009762] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 10:58:49 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 10:59:08 2026 kern.info kernel: [1567677.208886] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 10:59:08 2026 kern.info kernel: [1567677.214343] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 10:59:08 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 11:00:26 2026 kern.info kernel: [1567755.241218] mt7530-mdio mdio-bus:1f lan2: Link is Up - 100Mbps/Full - flow control rx/tx
Sat Nov 21 11:00:26 2026 kern.info kernel: [1567755.249579] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 11:00:26 2026 kern.info kernel: [1567755.255016] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 11:00:26 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 11:01:55 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 11:01:55 2026 kern.info kernel: [1567844.211849] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 11:01:55 2026 kern.info kernel: [1567844.217347] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 11:03:15 2026 kern.info kernel: [1567924.241144] mt7530-mdio mdio-bus:1f lan2: Link is Up - 100Mbps/Full - flow control rx/tx
Sat Nov 21 11:03:15 2026 kern.info kernel: [1567924.249525] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 11:03:15 2026 kern.info kernel: [1567924.254992] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 11:03:15 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 11:03:25 2026 kern.info kernel: [1567933.941931] mtk_soc_eth 1e100000.ethernet wan: Link is Down
Sat Nov 21 11:03:25 2026 daemon.notice netifd: Network device 'wan' link is down
Sat Nov 21 11:03:25 2026 daemon.notice netifd: Interface 'wan' has link connectivity loss
Sat Nov 21 11:03:25 2026 daemon.notice netifd: Interface 'wan6' has link connectivity loss
Sat Nov 21 11:03:25 2026 daemon.notice netifd: wan (8371): udhcpc: received SIGTERM
Sat Nov 21 11:03:25 2026 daemon.notice netifd: wan (8371): udhcpc: unicasting a release of 100.125.131.245 to 100.125.128.1
Sat Nov 21 11:03:25 2026 daemon.notice netifd: wan (8371): udhcpc: sending release
Sat Nov 21 11:03:25 2026 daemon.notice netifd: wan (8371): udhcpc: entering released state
Sat Nov 21 11:03:25 2026 daemon.notice netifd: wan (8371): Command failed: ubus call network.interface notify_proto { "action": 0, "link-up": false, "keep": false, "interface": "wan" } (Permission denied)
Sat Nov 21 11:03:25 2026 daemon.notice netifd: Interface 'wan' is now down
Sat Nov 21 11:03:25 2026 daemon.warn dnsmasq[1]: no servers found in /tmp/resolv.conf.d/resolv.conf.auto, will retry
Sat Nov 21 11:03:26 2026 daemon.notice netifd: Interface 'wan6' is now down
Sat Nov 21 11:03:27 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:03:30 2026 kern.info kernel: [1567938.556040] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 11:03:30 2026 kern.info kernel: [1567938.561714] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 11:03:30 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 11:04:13 2026 daemon.notice netifd: Network device 'wan' link is up
Sat Nov 21 11:04:13 2026 daemon.notice netifd: Interface 'wan' has link connectivity
Sat Nov 21 11:04:13 2026 daemon.notice netifd: Interface 'wan' is setting up now
Sat Nov 21 11:04:13 2026 kern.info kernel: [1567981.780836] mtk_soc_eth 1e100000.ethernet wan: Link is Up - 1Gbps/Full - flow control off
Sat Nov 21 11:04:13 2026 daemon.notice netifd: Interface 'wan6' has link connectivity
Sat Nov 21 11:04:13 2026 daemon.notice netifd: Interface 'wan6' is setting up now
Sat Nov 21 11:04:13 2026 daemon.notice netifd: wan (4119): udhcpc: started, v1.36.1
Sat Nov 21 11:04:13 2026 daemon.notice netifd: wan (4119): udhcpc: broadcasting discover
Sat Nov 21 11:04:17 2026 daemon.notice netifd: wan (4119): udhcpc: broadcasting discover
Sat Nov 21 11:04:17 2026 daemon.notice netifd: wan (4119): udhcpc: broadcasting select for 100.125.131.245, server 100.125.128.1
Sat Nov 21 11:04:17 2026 daemon.notice netifd: wan (4119): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 11:04:17 2026 daemon.notice netifd: Interface 'wan' is now up
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: reading /tmp/resolv.conf.d/resolv.conf.auto
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using nameserver 8.8.8.8#53
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using nameserver 8.8.4.4#53
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for test
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for onion
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for localhost
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for local
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for invalid
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for bind
Sat Nov 21 11:04:17 2026 daemon.info dnsmasq[1]: using only locally-known addresses for lan
Sat Nov 21 11:04:18 2026 user.notice firewall: Reloading firewall due to ifup of wan (wan)
Sat Nov 21 11:04:18 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:04:53 2026 kern.info kernel: [1568021.491105] mt7530-mdio mdio-bus:1f lan2: Link is Up - 100Mbps/Full - flow control rx/tx
Sat Nov 21 11:04:53 2026 kern.info kernel: [1568021.499519] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 11:04:53 2026 kern.info kernel: [1568021.504971] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 11:04:53 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 11:05:00 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 11:05:00 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 11:05:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:05:00 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa
Sat Nov 21 11:05:00 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.116 6a:8b:c3:64:be:aa MacBookPro
Sat Nov 21 11:05:04 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:05:09 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:12:00 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:17:12 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 IEEE 802.11: authenticated
Sat Nov 21 11:17:13 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 IEEE 802.11: associated (aid 1)
Sat Nov 21 11:17:13 2026 daemon.info hostapd: phy0-ap0: STA 1c:65:9d:cf:2f:23 WPA: pairwise key handshake completed (RSN)
Sat Nov 21 11:17:13 2026 daemon.notice hostapd: phy0-ap0: EAPOL-4WAY-HS-COMPLETED 1c:65:9d:cf:2f:23
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23 lenovo-Ideapad-Z560
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPDISCOVER(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPOFFER(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23
Sat Nov 21 11:17:13 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.155 1c:65:9d:cf:2f:23 lenovo-Ideapad-Z560
Sat Nov 21 11:17:58 2026 kern.info kernel: [1568806.642902] mt7530-mdio mdio-bus:1f lan2: Link is Down
Sat Nov 21 11:17:58 2026 kern.info kernel: [1568806.648739] br-lan: port 2(lan2) entered disabled state
Sat Nov 21 11:17:58 2026 daemon.notice netifd: Network device 'lan2' link is down
Sat Nov 21 11:18:00 2026 kern.info kernel: [1568808.696197] mt7530-mdio mdio-bus:1f lan2: Link is Up - 100Mbps/Full - flow control rx/tx
Sat Nov 21 11:18:00 2026 kern.info kernel: [1568808.704588] br-lan: port 2(lan2) entered blocking state
Sat Nov 21 11:18:00 2026 kern.info kernel: [1568808.709980] br-lan: port 2(lan2) entered forwarding state
Sat Nov 21 11:18:00 2026 daemon.notice netifd: Network device 'lan2' link is up
Sat Nov 21 11:18:23 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:19:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:29:02 2026 daemon.err uhttpd[1659]: [info] luci: accepted login on / for root from 192.168.1.116
Sat Nov 21 11:29:11 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:31:25 2026 authpriv.info dropbear[4421]: Child connection from 192.168.1.116:59212
Sat Nov 21 11:31:32 2026 authpriv.notice dropbear[4421]: Password auth succeeded for 'root' from 192.168.1.116:59212
Sat Nov 21 11:33:36 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:34:17 2026 daemon.notice netifd: wan (4119): udhcpc: sending renew to server 100.125.128.1
Sat Nov 21 11:34:17 2026 daemon.notice netifd: wan (4119): udhcpc: lease of 100.125.131.245 obtained from 100.125.128.1, lease time 3600
Sat Nov 21 11:35:39 2026 authpriv.info useradd[4449]: new user: name=netadmin-agent-01, UID=1001, GID=100, home=/home/netadmin-agent-01, shell=/bin/ash, from=/dev/pts/0
Sat Nov 21 11:36:16 2026 auth.err passwd: password for netadmin-agent-01 changed by root
Sat Nov 21 11:37:52 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:40:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPREQUEST(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe
Sat Nov 21 11:40:37 2026 daemon.info dnsmasq-dhcp[1]: DHCPACK(br-lan) 192.168.1.201 3e:81:b4:fe:b8:fe Xiaomi-13T-Pro
Sat Nov 21 11:41:51 2026 daemon.warn odhcpd[1545]: No default route present, overriding ra_lifetime!
Sat Nov 21 11:42:09 2026 authpriv.info dropbear[4421]: Exit (root) from <192.168.1.116:59212>: Disconnect received
Sat Nov 21 11:42:12 2026 authpriv.info dropbear[4541]: Child connection from 192.168.1.116:61914
Sat Nov 21 11:42:18 2026 authpriv.notice dropbear[4541]: Password auth succeeded for 'netadmin-agent-01' from 192.168.1.116:61914
Sat Nov 21 11:42:45 2026 authpriv.notice sudo: netadmin-agent-01 : TTY=pts/0 ; PWD=/ ; USER=root ; COMMAND=/usr/sbin/netadmin status
Sat Nov 21 11:43:16 2026 authpriv.notice sudo: netadmin-agent-01 : TTY=pts/0 ; PWD=/ ; USER=root ; COMMAND=/usr/sbin/netadmin network-config
Sat Nov 21 11:43:36 2026 authpriv.notice sudo: netadmin-agent-01 : TTY=pts/0 ; PWD=/ ; USER=root ; COMMAND=/usr/sbin/netadmin logs
netadmin-agent-01@OpenWrt:/$ 

```

