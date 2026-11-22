# Step 05 — UART serial console (diagnostic last resort)

## Why
Every image so far is downloaded but silently ignored, and Ethernet gives us no visibility into
U-Boot's decision. A serial console is the **only** way to read U-Boot's messages, see the exact
reason it rejects the image, and interact with it directly (stop autoboot, `tftpboot`/`bootm`/
`nand write` manually).

## Requires
- A 3.3 V USB-UART adapter (e.g. CP2102/CH340/FT232).
- Access to the board's UART pads (R4A has an unpopulated 4-pin header: GND / TX / RX / VCC,
  115200 8N1, **3.3 V logic** — do NOT use 5 V).
- `screen` or `minicom` on the host.

## Procedure
1. Wire GND↔GND, TX↔RX, RX↔TX (cross), leave VCC unconnected unless needed.
2. `screen /dev/ttyUSB0 115200`
3. Power the router and capture the full boot log; stop autoboot when prompted, then inspect /
   manually boot the served image.

## Expected outcome
The boot log shows the exact error (e.g. image header/checksum check, "Unrecognized image", etc.).

## Result
The definitive diagnosis — the finding here decides whether the recovery is a stock-flash, a
manual `nand write`, or a hardware fault.
