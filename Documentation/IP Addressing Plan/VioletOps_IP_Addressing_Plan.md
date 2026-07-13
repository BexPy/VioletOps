# VioletOps IP Addressing Plan

Status: In Progress  
Last Updated: July 11, 2026

## Home Management Network

Network: `10.0.0.0/24`

### Host 1

- Device: Original VioletOps Hyper-V host
- Connection: Wi-Fi
- IPv4 address: `10.0.0.130`
- Address role: Home-network management
- VioletOps static assignment: No

### Host 2

- Device name: `DESKTOP-OD4CHNC`
- Connection: Ethernet directly to home router
- IPv4 address: `10.0.0.110`
- Address role: Temporary home-network management
- VioletOps static assignment: No
- Future address design: Pending

## VioletOps LAN

Network: `10.10.10.0/24`

- OPNsense LAN gateway: `10.10.10.1/24`
- Host 1 VioletOps LAN adapter: `10.10.10.2/24`
- DHCP range: `10.10.10.100–10.10.10.199`
- Host 2 VioletOps LAN address: Not assigned
- Inter-host lab network: Not implemented

## Current Addressing Decision

- No new static IP addresses were assigned during Phase 2.5.
- Host 2 now uses Wi-Fi management at `10.0.0.226`; Ethernet `10.0.0.110` is no longer the active management path.
- No Host 2 VLAN, gateway, DNS, or VioletOps LAN address has been configured.
- OPNsense WAN remains disconnected.
## Host 2 Wi-Fi Management Address

- Host: `DESKTOP-OD4CHNC`
- Interface: `Wi-Fi 2`
- SSID profile: `WiFi`
- IPv4 address: `10.0.0.226`
- Default gateway: `10.0.0.1`
- Network category: Private
- Purpose: Host 2 management connection
- Host 2 Hyper-V Default Switch address: `192.168.240.1`
  - This is an internal Hyper-V address, not a management address.


