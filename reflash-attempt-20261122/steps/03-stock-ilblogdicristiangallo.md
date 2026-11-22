# Step 03 — Serve stock firmware from ilblogdicristiangallo/miwifitool-debrick-xiaomi — ALTERNATE

## Why
The repo `https://github.com/ilblogdicristiangallo/miwifitool-debrick-xiaomi/` hosts
`Firmware Xiaomi Mi 4a Gigabit for OpenWRTInvasion.zip` — an alternate source of the same
vulnerable stock image. Try it only if the OpenWRTInvasion-hosted files in step 02 are unavailable
or fail to flash.

## Requires
- Manually download `Firmware Xiaomi Mi 4a Gigabit for OpenWRTInvasion.zip` from that repo's
  Google Drive link and extract the `.bin` inside. (The repo is unvetted — 4 stars, unsigned
  binaries — so verify the extracted image's hash against a known value if possible, and prefer
  step 02 whenever possible.)

## Procedure
Same as step 02, but copy the extracted `.bin` to `assets/tftp-root/miwifi.bin` and set
`dhcp-boot=miwifi.bin,...`.

## Expected outcome / Result
Identical to step 02.
