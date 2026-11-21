# Task description

The goal - restore access to a router. Router spec - see in `router-spec.md`, it shows label through ocr, so not necessarily 100% accurate.

What I wanted: re-shell it to openwrt.

Actual result: did not finish well. Current state unknown.
I know I was able to log in. However, I have my main router, very similar, also 4A gigabit, should be similar. Working perfectly for many years with openwrt.

My old and working router is assigning ips from 192.168.1.x

The new - I tried to assign 192.268.2.x and I think that's where I maybe messed things up

Also, it permanently shows orange indicator. Maybe it means it's in some recovery state. I am not sure.

Unfortunately, my experiments with this were quite long ago... And I don't remember where did I land well. But I think, that's all knowledge I have.

I am now a non-privileged user, as it should be normal... Let me know if any commands or commands with sudo are needed - I will assist and install. I am giving access to nmcli command through nmcli-proxy helper script, found in current folder.

## Network setup

This is quite hard to understand for me, how to make all work alltogether. If I configure network interface to static access to router - no global internet, normal work is not possible.
If I configure network interface to dhcp, I have internet, but no access to router - work is not possible. I tried to ask ai and it sounds it is possible to work with both interfaces at the same time but I am not sure, in details. I hope it is possible.

Existing interfaces - wifi can be used 
`ahome-60let-2-24` is normally working regular internet connection, served through older openwrt at 192.168.1.1. This is 2.4G, there is a sister copy with "5" in name, for 5G. I think both are equally fine, or 5G for some reason was looking less stable... But basically both can be used.

NITKA-WORK-VPN-2G (or same 5G) is also available but should not be used

Then, the RJ45 connection is currently plugged to router.

So, I hope both connections can be used at the same time, but I can't be sure.

