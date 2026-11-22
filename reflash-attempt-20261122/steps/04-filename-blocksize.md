# Step 04 — Vary TFTP filename and blocksize

## Why
U-Boot's TFTP filename is DHCP-driven in our captures, but some Xiaomi bootloaders branch their
behaviour on the filename (e.g. `test.bin` = boot-test vs `miwifi.bin` = flash) or mis-handle
large TFTP blocks. If the stock image in step 02 downloaded but did not flash, try alternate names
and a forced 512-byte blocksize.

## Requires
- The stock image in `assets/tftp-root/`.
- Baseline from step 00.

## Procedure
1. Serve the stock image under multiple names at once:
   ```sh
   cd assets/tftp-root
   cp miwifi.bin miwifi_r4a_firmware_72d65_2.28.62.bin
   cp miwifi.bin test.bin
   cp miwifi.bin firmware.bin
   ```
   Then run one recovery pass per `dhcp-boot=` value (`miwifi.bin`, then the original filename,
   then `test.bin`).
2. Force 512-byte blocks using the standalone server instead of dnsmasq (dnsmasq negotiates
   1468-byte blocks):
   ```sh
   sudo python3 assets/tftpserver.py assets/tftp-root   # serves any requested basename at 512-byte blocks
   ```
   Run a pass with this server and `dhcp-boot=miwifi.bin` (dnsmasq still does DHCP; or run dnsmasq
   with TFTP disabled so it only answers DHCP).

## Expected outcome
If the trigger is filename- or blocksize-dependent, one of these passes flashes the image and the
router reboots.

## Result
- **Success:** router flashes → step 06.
- **Still nothing:** the image is being rejected for a reason we can't see over Ethernet → step 05
  (UART serial console).
