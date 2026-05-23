#!/bin/bash
NETPLAN_FILE="/etc/netplan/01-custom-config.yaml"

cat << EOF > "$NETPLAN_FILE"
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - 192.168.1.100/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

netplan apply
echo "Static IP configuration on eth0 successfully applied using netplan."
