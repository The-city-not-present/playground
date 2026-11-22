# agent-proxy

A small, auditable Python 3 wrapper around a fixed set of privileged network
tools that lets an **unprivileged user** (e.g. an automation agent) operate them
**without** getting full root/sudo access.

Debian/Ubuntu/Linux Mint specific (NetworkManager + iproute2 + dnsmasq +
tcpdump), but the script is otherwise plain Python 3 and portable. Scripted on
purpose: no compiled binaries, every privileged action is a visible invocation.

## What it can do

| Command | What it does | Root? |
| --- | --- | --- |
| `agent-proxy nmcli list [--active]` | List connection profiles | no |
| `agent-proxy nmcli devices` | Show interface status | no |
| `agent-proxy nmcli show --connection <id>` / `--device <if>` | Show details | no |
| `agent-proxy nmcli set-static ...` | Assign a static IPv4 and activate it | yes |
| `agent-proxy nmcli set-dhcp ...` | Switch a connection back to DHCP and activate | yes |
| `agent-proxy nmcli renew ...` | Force a DHCP lease renewal | yes |
| `agent-proxy nmcli restart ...` | Restart an interface / connection | yes |
| `agent-proxy nmcli reapply --device <if>` | Reapply the active profile | yes |
| `agent-proxy ip addr [--dev <if>]` | Show addresses | no |
| `agent-proxy ip link [--dev <if>]` | Show links | no |
| `agent-proxy ip neigh [--dev <if>]` | Show neighbour (ARP) table | no |
| `agent-proxy ip route [--dev <if>]` | Show routes | no |
| `agent-proxy ip link-set --device <if> up/down` | Bring a link up/down | yes |
| `agent-proxy dnsmasq start ...` | Start a scoped DHCP server | yes |
| `agent-proxy dnsmasq stop` | Stop dnsmasq | yes |
| `agent-proxy tcpdump capture ...` | Capture packets | yes |
| `agent-proxy tftp serve --directory <dir>` | Serve a directory over TFTP | yes |
| `agent-proxy sudoers` | Print the sudoers rule to install | no |
| `agent-proxy doctor` | Verify environment and sudoers setup | no |

## The privilege technique

The script normally runs as the unprivileged agent. For privileged operations it
**re-executes itself** under `sudo -n` (becoming root only for that one run),
then runs the underlying tool with a **fixed, validated** argv list (absolute
paths, never a shell string), so there is no shell-injection surface.

The sudoers rule grants access to **this script only** — never the underlying
tools directly:

```
<user> ALL=(root) NOPASSWD: /usr/local/bin/agent-proxy *
```

Why not per-tool rules? `tcpdump` (`-z`) and `dnsmasq` (`--dhcp-script`) can
spawn arbitrary commands, so a wildcard rule for either would be a privilege
escalation. Granting sudo to this one root-owned, non-writable proxy keeps the
*only* escalation surface inside this file, where every operation is validated.

Inputs are validated up front: interface names, IPv4/CIDR addresses, DNS
servers, DHCP range/lease, boot filename (bare name, no path), and file paths
(which must be under the agent's home or `/tmp`, so `tcpdump -w` cannot clobber
system files and TFTP cannot serve `/etc`). Capture filters are passed as a
single argument (no shell), never starting with `-`.

## Requirements

- Python 3.8+ (standard library only)
- `nmcli`, `ip`, `dnsmasq`, `tcpdump`, `pkill`, `python3`, `sudo`

## Install

### Option A: one command

```sh
sudo ./install.sh
```

Installs the script to `/usr/local/bin/agent-proxy` (root-owned, `0755`), the
bundled `tftpserver.py` to `/usr/local/lib/agent-proxy/`, and writes a scoped
`/etc/sudoers.d/agent-proxy` rule for the user that invoked `sudo`, validating
it with `visudo` first.

To install for an agent that **cannot run `sudo` itself** (the common case for
an automation account), have an admin run the installer with `--user`:

```sh
sudo ./install.sh --user agent
```

This grants the passwordless sudoers rule to `agent` instead of the admin who
invoked `sudo`, and validates that `agent` is an existing local account before
installing anything. The rule always points at the installed
`/usr/local/bin/agent-proxy`; you can eyeball its shape ahead of time with
`agent-proxy sudoers --user agent` (run from a checkout this prints the
checkout path, but the shape — one `NOPASSWD` line scoped to the proxy — is the
same).

### Option B: manual

```sh
sudo install -o root -g root -m 0755 ./agent-proxy /usr/local/bin/agent-proxy
sudo install -d -o root -g root -m 0755 /usr/local/lib/agent-proxy
sudo install -o root -g root -m 0644 ./tftpserver.py /usr/local/lib/agent-proxy/tftpserver.py
sudo sh -c 'agent-proxy sudoers --user agent > /etc/sudoers.d/agent-proxy && chmod 0440 /etc/sudoers.d/agent-proxy && visudo -c -f /etc/sudoers.d/agent-proxy'
agent-proxy doctor
```

## Usage examples

```sh
# discover the network state
agent-proxy nmcli list
agent-proxy nmcli devices
agent-proxy ip addr
agent-proxy ip neigh
agent-proxy ip link-set --device eth0 up

# set a static IP / switch back to DHCP
agent-proxy nmcli set-static --device eth0 --address 192.168.1.10/24 --gateway 192.168.1.1 --dns 8.8.8.8
agent-proxy nmcli set-dhcp --device eth0

# serve DHCP to the router in recovery mode, then hand out a bootfile
agent-proxy dnsmasq start --interface eth0 --range 192.168.1.10,192.168.1.20,12h --boot openwrt-initramfs.bin
# serve the firmware over TFTP (UDP :69) from a directory
agent-proxy tftp serve --directory ~/firmware
# watch the router's DHCP/TFTP traffic
agent-proxy tcpdump capture --interface eth0 --expression 'port 67 or port 69' --count 50
# stop the DHCP server
agent-proxy dnsmasq stop

# preview what would run, without executing privileged commands
agent-proxy --dry-run tcpdump capture --interface eth0 --count 50
```

`dnsmasq start` daemonizes by default; stop it with `agent-proxy dnsmasq stop`
(`--no-daemon` keeps it in the foreground for debugging). `tftp serve` runs in
the foreground — background it, or run it in its own terminal.

## Error reporting

Failures are loud and preserve the original error: the exact command line, exit
code, and original stdout/stderr are always printed. A specific hint is printed
when `sudo` refuses to elevate the proxy (i.e. the sudoers rule is missing).
Unexpected exceptions always print the full Python traceback; `--traceback`
also prints it for expected (handled) failures.

## Security notes

- Keep `/usr/local/bin/agent-proxy` owned by `root:root`, mode `0755`. If the
  agent could edit it, they could make the root-run script do arbitrary things.
  `agent-proxy doctor` checks this.
- The sudoers rule grants `sudo` only to the proxy itself. It is safe only
  because the proxy validates every operation; review it before adding sections.
- Output files (`tcpdump -w`) and served directories (`tftp --directory`,
  `dnsmasq --tftp-root`) are restricted to the agent's home and `/tmp`. Extend
  `_allowed_writable_roots()` in `agent-proxy` for other roots (e.g. `/srv/tftp`).
- `tftpserver.py` is vendored from
  <https://github.com/The-city-not-present/playground/blob/xiaomi-openwrt-restore/reflash/tftpserver.py>
  and hardened so symlinks cannot escape the served directory.
- Everything runs non-interactively (`sudo -n`), so an agent never hangs on a
  password prompt.

## Extending

`agent-proxy` is organised into clearly separated sections, one per tool. To add
a tool: copy a section, wire its `register_*` call into `build_parser()`, and
mark privileged commands with `@privileged`.

