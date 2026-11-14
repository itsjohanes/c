#!/bin/bash
set -e

sudo diskutil mount /dev/disk0s1

python3 - << 'EOF'
import plistlib

p = "/Volumes/EFI/EFI/OC/config.plist"
with open(p, "rb") as f:
    d = plistlib.load(f)

nvram = d["NVRAM"]["Add"]["7C436110-AB2A-4BBB-A880-FE41995C9F82"]
nvram["boot-args"] = "revpatch=auto,sbvmm -no_compat_check amfi=0x80 igfxonln=1 agdpmod=vit9696 -v debug=0x100 keepsyms=1"

with open(p, "wb") as f:
    plistlib.dump(d, f)

print("SUKSES: Akselerasi penuh UHD 630 siap!")
EOF

sudo reboot
