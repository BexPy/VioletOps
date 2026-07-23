# VioletOps Firewall Rules

Status: In Progress  
Last Updated: July 11, 2026

## OPNsense Current State

- Firewall platform: OPNsense 26.1.6
- VM host: Host 1
- WAN interface: `hn0`
- LAN interface: `hn1`
- LAN address: `<OPNSENSE-LAN-IP>/24`
- LAN DHCP range: `<OPNSENSE-LAN-IP>00–<OPNSENSE-LAN-IP>99`
- WAN cable: Disconnected
- WAN validation: Not completed

## Phase 2.5 Change Record

- No firewall rules were added.
- No firewall rules were modified.
- No firewall rules were deleted.
- No NAT rules were added or modified.
- No VLAN interfaces were created.
- No Host 2 firewall policy was created.
- No inter-host traffic policy was created.

## Current Decision

OPNsense firewall configuration remains paused at the verified LAN baseline until the dual-host physical, monitor, storage, and networking design is completed.

## Host 1 Management Network ICMP Rule

- Host: `<HOST-1-NAME>`
- Interface: `Wi-Fi`
- Network profile: Private
- Rule name: `Core Networking Diagnostics - ICMP Echo Request (ICMPv4-In)`
- Direction: Inbound
- Protocol: ICMPv4
- Action: Allow
- Enabled: True
- Scope: Private profile only
- Purpose: Allow verified management connectivity from Host 2
- Verification: Host 2 successfully pinged `<HOST-1-MANAGEMENT-IP>`
- Public network exposure: Not allowed

## Host 1 Management Network ICMP Rule

- Host: `<HOST-1-NAME>`
- Interface: `Wi-Fi`
- Network profile: Private
- Rule name: `Core Networking Diagnostics - ICMP Echo Request (ICMPv4-In)`
- Direction: Inbound
- Protocol: ICMPv4
- Action: Allow
- Enabled: True
- Scope: Private profile only
- Purpose: Allow verified management connectivity from Host 2
- Verification: Host 2 successfully pinged `<HOST-1-MANAGEMENT-IP>`
- Public network exposure: Not allowed

## Mouse Without Borders Private-Network Rules

### Host 1

- Rule: `VioletOps - Mouse Without Borders Inbound`
- Direction: Inbound
- Action: Allow
- Profile: Private
- Program:
  - `C:\Users\Admin\AppData\Local\PowerToys\PowerToys.MouseWithoutBorders.exe`

### Host 2

- Rule: `VioletOps - Mouse Without Borders Inbound`
- Direction: Inbound
- Action: Allow
- Profile: Private
- Program:
  - `C:\Users\pp\AppData\Local\PowerToys.MouseWithoutBorders.exe`
- Rule: `VioletOps - Mouse Without Borders Helper Inbound`
- Direction: Inbound
- Action: Allow
- Profile: Private
- Program:
  - `C:\Users\pp\AppData\Local\PowerToys.MouseWithoutBordersHelper.exe`

### Verification

- Both hosts use the trusted home Wi-Fi profile `WiFi`.
- Both Wi-Fi network profiles are set to Private.
- Mouse movement between monitors works.
- Cross-PC clipboard copy and paste works.
- PowerToys `Refresh connections` restored the session.
- Public-profile access is not allowed.
