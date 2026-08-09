# OPNsense-Gateway VM Inventory

Status: Complete
Last Updated: August 8, 2026

## Identity

- VM name: OPNsense-Gateway
- Intended role: VioletOps virtual firewall and gateway
- Hypervisor: Microsoft Hyper-V
- Deployment state: Installed and validated

## Compute Resources

- Virtual processors: 2
- Startup memory: 4 GB
- Dynamic memory: Disabled

## Storage

- VM storage folder: `V:\HyperV-VMs\OPNsense-Gateway`
- Operating system disk: `V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx`

## Network Adapters

### WAN Adapter

- Adapter name: `WAN`
- MAC address: <OPNSENSE-WAN-MAC>
- Intended role: OPNsense WAN
- Current virtual switch: `VioletOps-WAN`
- Physical WAN path: Connected through managed-switch VLAN 10

### LAN Adapter

- Adapter name: `LAN`
- MAC address: <OPNSENSE-LAN-MAC>
- Intended role: OPNsense LAN
- Current virtual switch: `VioletOps-LAN`
- IPv4 address: <OPNSENSE-LAN-IP>/24

## Checkpoints

- Automatic checkpoints: Disabled

## Related Network Configuration

- VioletOps LAN switch: `VioletOps-LAN`
- Switch type: Internal
- VioletOps LAN network: `<VIOLETOPS-LAN>`
- Windows host LAN address: `<HOST-1-LAB-IP>/24`

## Change Record

### July 3, 2026

- Created the initial OPNsense VM inventory record.
- Recorded the verified compute, storage, checkpoint, and network state.
- Connected only the OPNsense `LAN` adapter to `VioletOps-LAN`.
- Verified the OPNsense `WAN` adapter remains without a virtual switch.
- Recorded both virtual adapter MAC addresses.

### July 3, 2026 — WAN Switch Created

- Created the external Hyper-V switch `VioletOps-WAN`.
- Bound `VioletOps-WAN` to the Intel I219-LM Ethernet adapter.
- The OPNsense `WAN` adapter remains unattached.
- OPNsense remains powered off.

### July 3, 2026 — WAN Adapter Attached

- Connected the OPNsense `WAN` adapter to `VioletOps-WAN`.
- Verified final adapter mapping:
  - `WAN` → `VioletOps-WAN`
  - `LAN` → `VioletOps-LAN`
- Verified OPNsense remained powered off during the change.

### July 3, 2026 — Memory Increase

- Increased OPNsense startup memory from 2 GB to 4 GB.
- Dynamic memory remains disabled.
- Change was required because the OPNsense 26.1 ZFS installer requires at least 3 GB of RAM.
- Verified Hyper-V reports 4 GB static startup memory.
- Physical WAN cable remained disconnected.
