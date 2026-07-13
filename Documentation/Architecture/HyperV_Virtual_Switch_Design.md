# VioletOps Hyper-V Virtual Switch Design

Status: Complete  
Started: July 3, 2026

## Current Host Connectivity

- Active host connection: Wi-Fi
- Wi-Fi adapter: Intel(R) Wireless-AC 9560 160MHz
- Host Wi-Fi IPv4 address: 10.0.0.130
- Physical Ethernet adapter: Intel(R) Ethernet Connection (7) I219-LM
- Physical Ethernet status: Disconnected
- Existing Microsoft-managed switch: Default Switch

## VioletOps-LAN

- Switch name: VioletOps-LAN
- Hyper-V switch type: Internal
- Purpose: Isolated VioletOps lab LAN and host management access
- Physical adapter binding: None
- Host virtual adapter: vEthernet (VioletOps-LAN)
- Host virtual adapter status: Up
- Host virtual adapter MAC address: 00-15-5D-0A-F0-13
- Host IPv4 address: 10.10.10.2/24
- Network: 10.10.10.0/24
- Default gateway: None
- DNS servers: None
- Connected virtual machines: OPNsense-Gateway
- OPNsense connection: LAN adapter attached to VioletOps-LAN

## Change Record

### July 3, 2026

- Created the `VioletOps-LAN` internal Hyper-V virtual switch.
- Verified the matching Windows host adapter was created and is operational.
- Assigned static IPv4 address `10.10.10.2/24` to `vEthernet (VioletOps-LAN)`.
- Verified no default gateway is configured.
- Verified no DNS servers are configured.
- Confirmed the adapter remains isolated from the host Wi-Fi route.
- No OPNsense adapters were connected during these changes.
- No physical network adapters were modified.

### July 3, 2026 — OPNsense LAN Attachment

- Connected the `OPNsense-Gateway` LAN adapter to `VioletOps-LAN`.
- OPNsense LAN adapter MAC address: `00155D0AF012`
- Verified the OPNsense WAN adapter remains without a virtual switch.
- No WAN switch was created.
- OPNsense remains powered off.

## VioletOps-WAN

- Switch name: VioletOps-WAN
- Hyper-V switch type: External
- Physical adapter: Intel(R) Ethernet Connection (7) I219-LM
- Windows adapter name: Ethernet
- Allow management operating system: False
- Host-side virtual adapter: None
- Host IPv4 binding on Ethernet: Disabled
- Host IPv6 binding on Ethernet: Disabled
- Hyper-V Extensible Virtual Switch binding: Enabled
- Physical link status during configuration: Disconnected
- Intended purpose: Dedicated OPNsense WAN uplink

### July 3, 2026 — VioletOps WAN Switch

- Created the `VioletOps-WAN` external Hyper-V switch.
- Bound the switch to the Intel I219-LM Ethernet adapter.
- Disabled host management access on the WAN switch.
- Verified Wi-Fi remains the host's only default-gateway interface.
- Verified no `vEthernet (VioletOps-WAN)` host adapter exists.
- Verified IPv4 and IPv6 are disabled on the physical Ethernet host interface.
- Verified the Hyper-V Extensible Virtual Switch binding is enabled.
- OPNsense WAN adapter is attached to `VioletOps-WAN`.

### July 3, 2026 — OPNsense WAN Attachment

- Connected the `OPNsense-Gateway` WAN adapter to `VioletOps-WAN`.
- Verified final network mapping:
  - `WAN` → `VioletOps-WAN`
  - `LAN` → `VioletOps-LAN`
- Verified OPNsense remained powered off during the change.

## Final Verified State

- `Default Switch`: Internal, Microsoft-managed
- `VioletOps-LAN`: Internal
- `VioletOps-WAN`: External, bound to Intel I219-LM
- Windows LAN address: `10.10.10.2/24`
- OPNsense `LAN` → `VioletOps-LAN`
- OPNsense `WAN` → `VioletOps-WAN`
- OPNsense power state: Off
- Hyper-V virtual switch rebuild phase: Complete
