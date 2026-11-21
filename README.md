# nmcli-proxy

A small, auditable Python wrapper around NetworkManager's `nmcli` that lets an
**unprivileged user** (e.g. an automation agent) perform a fixed, narrow set of
network tasks **without** getting full root/sudo access.

Debian/Ubuntu/Linux Mint specific (NetworkManager), but the script is otherwise
plain Python 3 and portable. Scripted on purpose: no compiled binaries, every
privileged action is a visible `nmcli` invocation.

## What it can do

| Command | What it does | Needs root? |
| --- | --- | --- |
| `nmcli-proxy list [--active]` | List connection profiles | no (read-only) |
| `nmcli-proxy devices` | Show interface status | no (read-only) |
| `nmcli-proxy show --connection <id>` / `--device <if>` | Show details | no (read-only) |
| `nmcli-proxy set-static ...` | Assign a static IPv4 to a connection and activate it | yes |
| `nmcli-proxy set-dhcp ...` | Switch a connection back to DHCP and activate it | yes |
| `nmcli-proxy renew ...` | Force a DHCP lease renewal (deactivate + activate) | yes |
| `nmcli-proxy restart ...` | Restart an interface / connection | yes |
| `nmcli-proxy reapply --device <if>` | Reapply the active profile to a device | yes |
| `nmcli-proxy sudoers` | Print the exact sudoers rules to install | no |
| `nmcli-proxy doctor` | Verify the environment and sudoers setup | no |

## The privilege technique

The script **never runs as root itself**. For privileged operations it:

1. Validates every input up front (IP/CIDR via `ipaddress`, interface-name
   regex, connection-name sanity) — fail early.
2. Builds a fixed `nmcli` command line and runs it via `sudo -n` with an
   **absolute path** and a **list of arguments** (never a shell string), so
   there is no shell-injection surface.
3. Relies on a `sudoers.d` rule that grants passwordless sudo for **only** the
   nmcli subcommands it needs — nothing else:

```
<user> ALL=(root) NOPASSWD: <nmcli> connection modify *
<user> ALL=(root) NOPASSWD: <nmcli> connection up *
<user> ALL=(root) NOPASSWD: <nmcli> connection down *
<user> ALL=(root) NOPASSWD: <nmcli> device disconnect *
<user> ALL=(root) NOPASSWD: <nmcli> device connect *
<user> ALL=(root) NOPASSWD: <nmcli> device reapply *
```

So the user/agent can manipulate network configuration, but cannot install
packages, edit files, run arbitrary commands as root, etc.

## Requirements

- Python 3.8+ (uses only the standard library)
- NetworkManager (`nmcli`)
- `sudo`

## Install

### Option A: one command

```sh
sudo ./install.sh
```

This installs the script to `/usr/local/bin/nmcli-proxy` (root-owned, `0755`)
and writes a scoped `/etc/sudoers.d/nmcli-proxy` rule for the user that invoked
`sudo`, validating it with `visudo` first.

### Option B: manual

```sh
# 1. install the script (root-owned and not group/other-writable, important)
sudo install -o root -g root -m 0755 ./nmcli-proxy /usr/local/bin/nmcli-proxy

# 2. install the sudoers rule (0440, root-owned)
sudo sh -c 'nmcli-proxy sudoers > /etc/sudoers.d/nmcli-proxy && chmod 0440 /etc/sudoers.d/nmcli-proxy && visudo -c -f /etc/sudoers.d/nmcli-proxy'

# 3. verify
nmcli-proxy doctor
```

## Usage examples

```sh
# discover what is there
nmcli-proxy list
nmcli-proxy devices
nmcli-proxy show --device eth0

# set a static IP (address is required, gateway/dns are cleared if omitted)
nmcli-proxy set-static --device eth0 --address 192.168.1.10/24 --gateway 192.168.1.1 --dns 8.8.8.8
nmcli-proxy set-static --connection 'Wired connection 1' --address 10.0.0.5/24 --dns 1.1.1.1,8.8.8.8

# switch back to DHCP
nmcli-proxy set-dhcp --device eth0

# re-retrieve the IP / force a DHCP renewal
nmcli-proxy renew --device eth0

# restart the interface / connection
nmcli-proxy restart --device eth0
nmcli-proxy restart --connection 'Wired connection 1'

# preview what would run (read-only queries still run so --device resolves)
nmcli-proxy --dry-run set-static --device eth0 --address 192.168.1.10/24
```

You can target operations either by `--connection <name-or-uuid>` or
`--device <iface>`; with `--device`, the active connection for that interface
is resolved automatically.

## Error reporting

Failures are loud and preserve the original error:

- The exact command line, exit code, and the original `stdout`/`stderr` are
  always printed.
- A specific hint is printed when `sudo` refuses to run `nmcli` (i.e. the
  sudoers rule is missing).
- Unexpected exceptions always print the full Python traceback.
- `--traceback` also prints the traceback for expected (handled) failures.

## Security notes

- Keep `/usr/local/bin/nmcli-proxy` owned by `root:root` and mode `0755`. If the
  agent user could edit the script, they could make the (root-run) sudo rules do
  arbitrary things — the installer handles this for you.
- The sudoers rules intentionally grant `nmcli connection modify *` (any
  property). That is "full network configuration" but still confined to nmcli;
  it is **not** arbitrary root. If you want to lock this down further, narrow
  the wildcard patterns to the exact `ipv4.*` properties used above.
- Everything is run non-interactively (`sudo -n`), so an agent never hangs on a
  password prompt; it fails immediately with a clear message instead.
