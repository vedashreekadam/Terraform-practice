#!/bin/bash
set -xe

# Detect the EBS volume (the second NVMe disk)
DEVICE=$(lsblk -dn -o NAME | grep nvme1n1 | sed 's|^|/dev/|')

# Create mount point
mkdir -p /data

# Format only if not already formatted
if ! file -s $DEVICE | grep -q "filesystem"; then
    mkfs.xfs $DEVICE
fi

# Mount the volume
mount $DEVICE /data

# Persist mount across reboots
echo "$DEVICE /data xfs defaults,nofail 0 2" >> /etc/fstab
