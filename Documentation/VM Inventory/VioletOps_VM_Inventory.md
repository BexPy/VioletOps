# VioletOps VM Inventory

Status: In Progress  
Last Updated: July 11, 2026

## Host 1 — Original VioletOps Hyper-V Host

### OPNsense-Gateway

- Host: Host 1
- State: Installed and validated
- Generation: 1
- Virtual processors: 2
- Startup memory: 4 GB static
- Dynamic memory: Disabled
- Automatic checkpoints: Disabled
- Virtual disk: 25 GB dynamic VHDX
- Storage path: `V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx`
- Operating system: OPNsense 26.1.6
- File system: ZFS
- WAN interface:
  - OPNsense device: `hn0`
  - MAC address: `00:15:5D:0A:F0:11`
  - Hyper-V switch: `VioletOps-WAN`
  - Physical WAN cable: Disconnected
- LAN interface:
  - OPNsense device: `hn1`
  - MAC address: `00:15:5D:0A:F0:12`
  - Hyper-V switch: `VioletOps-LAN`
  - IPv4 address: `10.10.10.1/24`
  - DHCP range: `10.10.10.100–10.10.10.199`
- Web GUI: `https://10.10.10.1`
- Current phase: Phase 2 paused before WAN validation

## Host 2 — DESKTOP-OD4CHNC

- Hyper-V status: Enabled and verified
- Existing virtual machines: 0
- Assigned VioletOps virtual machines: None
- Custom virtual switches: None
- Built-in virtual switches:
  - `Default Switch` — Internal
- VM workload role: Core server and monitoring host
- VM storage design: Configured and verified under `C:\HyperV`

## Placement Status

Initial VM placement has been approved, but no additional Windows, Linux, SIEM, Active Directory, or attack-simulation VMs have been created yet.

## Approved Planned VM Placement

### Host 1 — Planned

- Windows 11 client
  - Planned memory: 6 GB
  - Purpose: Domain client, monitored endpoint, and Atomic Red Team target
  - Deployment status: Not created
- Kali Linux
  - Planned memory: 4 GB
  - Purpose: Controlled attack and validation system
  - Deployment status: Not created

### Host 2 — Planned

- Windows Server / Active Directory
  - Planned memory: 4–6 GB
  - Purpose: Domain controller, DNS, users, groups, and Group Policy
  - Deployment status: Not created
- Wazuh server
  - Planned memory: 8 GB
  - Purpose: Endpoint monitoring, alerting, and security analytics
  - Deployment status: Not created
- Splunk server
  - Planned memory: 6–8 GB
  - Purpose: Log ingestion, dashboards, searches, and investigations
  - Deployment status: Not created

## Deferred Workloads

- Security Onion
  - Status: Deferred because of memory requirements
  - May be tested later while other monitoring VMs are powered off

## Inventory Control

- Approved placement does not mean the VMs have been created.
- Only `OPNsense-Gateway` currently exists.


## Host 2 Storage Assignment

- Host: `DESKTOP-OD4CHNC`
- Default VM configuration path:
  - `C:\HyperV\Virtual Machines`
- Default virtual disk path:
  - `C:\HyperV\Virtual Hard Disks`
- Planned Windows Server, Wazuh, and Splunk VMs will use these paths unless a different path is documented.
- Current Host 2 VM count: 0
- Storage assignment status: Configured and verified

