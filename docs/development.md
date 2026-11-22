# Development / environment

## Host
- `lenovo-Ideapad-Z560`, Linux Mint 22 (Wilma), NetworkManager.
- Interfaces: `wlp6s0` = WiFi to the main router (internet), `enp7s0` = Ethernet to the broken
  router.
- The agent runs as the unprivileged user `agent-instance-01` (uid 1002).

## agent-proxy (privileged networking without full sudo)
`nmcli-proxy/agent-proxy` is a scoped-sudo wrapper that lets the unprivileged agent drive the
networking commands needed for recovery. Installed at `/usr/local/bin/agent-proxy` with a sudoers
rule at `/etc/sudoers.d/agent-proxy` (so `sudo -n agent-proxy ...` works passwordless).

Relevant verbs:
- `ip addr-add/addr-flush/link-set/neigh-add/neigh-replace/neigh-del/neigh`
- `dnsmasq start/stop` (DHCP + TFTP)
- `tcpdump capture/stop`

Install: `sudo ./nmcli-proxy/install.sh --user agent-instance-01`.

## Recovery environment constants
- Recovery subnet: host `192.168.31.100/24`, router `192.168.31.1`.
- U-Boot recovery MAC: `82:73:78:2e:b6:69` (does NOT answer ARP for itself — pre-seed + keep-alive).
- TFTP root for the active attempt: `reflash-attempt-20261122/assets/tftp-root/`.

## Conventions
- Never modify `reflash-attempt-20261121/` (archive).
- Keep a single source of truth: current state lives in `docs/project-context.md`.
- Before running, stop any stale `dnsmasq`/`tftpserver.py`/`tcpdump`.
