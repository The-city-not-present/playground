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

## Timeline

Main router - xiaomi mi4a gigabit, re-flashed to openwrt back in times. I don't now exact date. Working fine. Conventionally assigning 192.168.1.x to devices in local network. Accessed through wifi.

The router that is not working now - bought second hand. I don't know the date, I see a log record Aug 2024.

When bought, it was working perfectly fine, with original chinese formware. Perfectly fast, wifi, wan - all was working. Nothing indicated physical issue.

Then, I tried to re-flash it to openwrt. I was able to get in, upload the image - I think this one but I am not sure /home/andrej/work/mi4a/openwrt-25.12.2-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin

Result - not working fine. Permanent orange led indicator. Struggled to configure networking. Tried to change address range to 129.168.2.x so that it is not conflicting with main router. From this point, lost access.

Then, Activities Nov 20. Prepared this folder `/home/andrej/work/xiaomi-openwrt-restore`, started agentic work. Agent was able to get in super quickly. I changed password to "freedom2agents". Then, I asked to verify config. Agent (deepseek v4 pro with higher reasoning) did not report any issues. I asked to configure network, wifi... There were certain problems with WAN. Something was not working. We tried to reconfigure to use LAN as WAN, and wifi for access. And we realized: 1. no events ever captured in WAN, cable is not visible, 2. wifi drivers crash, 3. permanent orange led. This means, need a new re-flash.

So, I asked agent to prepare a plan in this folder `/home/andrej/work/xiaomi-openwrt-restore/reflash`.

And then my next request was to go ahead with the plan.

Agent tried to roll 25.x firmware -> not worked. Then, tried 23.x as it was confirmed to be working on main router -> not worked. Agent said it's probably the chip is v2 but the image was for v1...

So, after it all, current state: unknown.

Typical behavior on boot: permanent orange led.

Typical behavior on boot with reset button - permanent orange for approx 5 seconds, then orange blinking, then permanent orange for maybe 10 seconds, and then pink blinking.

Current topology: I have lenovo laptop connected to internet (to main router) via wifi. The problematic router is connected to lenovo with rj45 from lan. Also, a rj45 cable is going from main router lan to problematic router wan (blue).

Please be aware of possible conflict: main router, that serves at wifi, assigns 192.168.1.x ips to devices from local network. Openwrt in recovery will still use 192.168.1.1. Accessing both from lenovo, through wired and wireless connection - not sure how much of a problem is it.


