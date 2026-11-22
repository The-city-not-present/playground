# Xiaomi Mi Router 4A Gigabit (v2) — recovery workspace

Working record of an effort to recover and cleanly re-flash a **Xiaomi Mi Router 4A Gigabit
Edition (R4A, v2)** that is stuck in the stock bootloader's TFTP recovery mode.

## Where to look
- **`docs/project-context.md`** — current state + full history + gotchas (start here).
- **`docs/roadmap.md`** — the ordered recovery plan and all image options.
- **`docs/development.md`** — host environment and the `agent-proxy` privileged-command helper.
- **`reflash-attempt-20261122/`** — **active work**; numbered, self-contained steps to try next.
- **`reflash-attempt-20261121/`** — the first (failed) attempt, kept untouched as an archive.
- **`router-spec.md`** — the router's label, via OCR (not 100 % accurate).
- **`working-router/`** — transcript of the *other* (working) R4A Gigabit, read-only reference.

## TL;DR of the situation
The router is **not reachable** and sits in **U-Boot TFTP recovery** (blinking pink LED). It will
download an image we serve, but it ignores the OpenWrt initramfs it was given. Next step is to
serve a **stock Xiaomi firmware image** (`miwifi_r4a_*.bin`), which the stock bootloader is designed
to flash. Full reasoning in `docs/project-context.md` and `docs/roadmap.md`.
