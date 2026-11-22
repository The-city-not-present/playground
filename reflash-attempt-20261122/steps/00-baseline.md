# Step 00 — Clean baseline

## Why
Recovery runs have failed before because of a stale TFTP server on :69, a leftover dnsmasq, or a
wrong host IP. Establish a known-good state and confirm the router is actually in recovery before
serving any image.

## Requires
- Router powered, Ethernet `enp7s0` → router **LAN** port.
- `agent-proxy` installed (see `docs/development.md`).

## Procedure
```sh
# 1. Stop anything stale
agent-proxy dnsmasq stop
agent-proxy tcpdump stop
sudo pkill -f tftpserver.py 2>/dev/null || true

# 2. Put enp7s0 on the recovery subnet
agent-proxy ip addr-flush --device enp7s0
agent-proxy ip addr-add   --device enp7s0 --address 192.168.31.100/24
agent-proxy ip link-set   --device enp7s0 up
agent-proxy ip addr --dev enp7s0   # expect 192.168.31.100/24

# 3. Confirm the router is in U-Boot recovery (blinking pink LED) — ask the user if unsure.
```

## Expected outcome
- Host: `enp7s0` = `192.168.31.100/24`.
- No `dnsmasq`/`tftpserver.py`/`tcpdump` running.
- Router LED blinking pink.

## Result
- **Success:** clean baseline → proceed to step 01.
- **Failure:** if `enp7s0` loses its IP (NetworkManager re-activating "Wired connection 1"),
  deactivate that profile or re-apply the address. If the LED is not blinking pink, the router is
  not in recovery — re-enter it (hold reset while powering on) and confirm with the user.
