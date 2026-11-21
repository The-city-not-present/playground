#!/usr/bin/env python3
"""Minimal read-only TFTP server for U-Boot recovery.

Usage (as root, since it binds UDP port 69):
    sudo python3 tftpserver.py /path/to/dir

It serves any file requested by basename from the given directory
(RRQ only; WRQ is rejected). U-Boot typically requests the image by a
short name (e.g. test.bin / miwifi.bin / the initramfs name), so place
copies under all likely names in the directory.
"""
import os
import socket
import sys

ROOT = sys.argv[1] if len(sys.argv) > 1 else "."

OP_RRQ = 1
OP_WRQ = 2
OP_DATA = 3
OP_ACK = 4
OP_ERROR = 5


def err_pkt(code, msg):
    return b"\x00\x05" + code.to_bytes(2, "big") + msg.encode() + b"\x00"


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(("0.0.0.0", 69))
    print(f"[tftp] serving from {os.path.abspath(ROOT)} on :69", flush=True)

    while True:
        try:
            data, addr = sock.recvfrom(516)
        except KeyboardInterrupt:
            break

        if len(data) < 2:
            continue
        op = int.from_bytes(data[:2], "big")

        if op == OP_RRQ:
            parts = data[2:].split(b"\x00")
            if len(parts) < 2:
                sock.sendto(err_pkt(0, "Bad request"), addr)
                continue
            filename = parts[0].decode(errors="replace")
            # Serve by basename only (prevents path traversal).
            path = os.path.join(ROOT, os.path.basename(filename))
            print(f"[tftp] RRQ {filename!r} from {addr}", flush=True)
            if not os.path.isfile(path):
                sock.sendto(err_pkt(1, "File not found"), addr)
                continue

            with open(path, "rb") as f:
                block = 1
                while True:
                    chunk = f.read(512)
                    sock.sendto(
                        b"\x00\x03" + block.to_bytes(2, "big") + chunk, addr
                    )
                    last = len(chunk) < 512
                    if last:
                        break
                    # Wait for ACK of this block.
                    try:
                        sock.settimeout(5)
                        ack, _ = sock.recvfrom(516)
                        sock.settimeout(None)
                    except socket.timeout:
                        print("[tftp] timeout waiting for ACK", flush=True)
                        break
                    if (
                        len(ack) >= 4
                        and ack[:2] == b"\x00\x04"
                        and int.from_bytes(ack[2:4], "big") == block
                    ):
                        block += 1
                    else:
                        break
        elif op == OP_WRQ:
            sock.sendto(err_pkt(2, "Write not allowed"), addr)
        else:
            sock.sendto(err_pkt(4, "Unknown opcode"), addr)


if __name__ == "__main__":
    main()
