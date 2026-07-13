# VioletOps Dual-Host Baseline Architecture

Status: In Progress  
Last Updated: July 11, 2026

## Scope

This document records the verified physical and virtualization baseline for the two-host VioletOps lab before Host 2 workload placement, storage redesign, monitor integration, or OPNsense WAN validation.

## Host 1 — Original VioletOps Hyper-V Host

- Model: Dell OptiPlex 7070 Micro
- CPU: Intel Core i7-9700
- RAM: 32 GB
- Storage: 1 TB NVMe SSD
- Operating system: Windows 11 Pro
- Hyper-V: Enabled
- Management connection: Wi-Fi
- Management IPv4 address: `10.0.0.130`
- VioletOps LAN host address: `10.10.10.2/24`
- Current assigned VM:
  - `OPNsense-Gateway`
- Current custom virtual switches:
  - `VioletOps-LAN` — Internal
  - `VioletOps-WAN` — External
- Physical Ethernet role:
  - Dedicated to `VioletOps-WAN`
- OPNsense WAN cable:
  - Disconnected

## Host 2 — DESKTOP-OD4CHNC

- Model: Dell OptiPlex 7070
- CPU: Intel Core i7-9700
- RAM: 32 GB
- Storage: 1 TB SK hynix PC801 NVMe SSD
- Operating system: Windows 11 Pro 25H2
- Hyper-V: Enabled and verified
- Current management connection: Ethernet directly to router
- Current management IPv4 address: `10.0.0.226`
- Ethernet MAC address: `E4-54-E8-96-76-5C`
- Ethernet link speed: 1 Gbps
- Existing virtual machines: 0
- Custom virtual switches: 0
- Built-in virtual switches:
  - `Default Switch` — Internal
- VM workload role: Core server and monitoring host
- VM storage design: Configured and verified under `C:\HyperV`
- USB Wi-Fi adapter driver: Installed and verified

## Shared Physical Infrastructure

- Managed switch:
  - TP-Link TL-SG108E
- Monitor 1:
  - Dell P2419H
  - Position: Left
  - Connected to Host 1 by DisplayPort-to-DisplayPort
- Monitor 2:
  - Dell P2419H
  - Position: Right
  - Connected to Host 2 by DisplayPort-to-DisplayPort
- Available video connectivity:
  - Each host has one unused DisplayPort output
  - Each monitor has one available HDMI input
  - Each monitor has one available DVI input
  - Two DisplayPort-to-HDMI cables are available
- Monitor USB connectivity:
  - Each monitor has two USB downstream ports
  - Each monitor has one SuperSpeed USB-B upstream port
- Current cross-host control:
  - Microsoft PowerToys Mouse Without Borders
  - Cross-PC copy and paste verified
  - Cross-host mouse control and clipboard sharing are working through PowerToys Mouse Without Borders
- KVM:
  - Not installed
  - Deferred as a later improvement
- Inter-host network design:
  - Deferred until Host 1 has an additional physical NIC or the topology is redesigned
## Current Logical Topology

```text
Internet / Home Router
        |
        +---- Wi-Fi ---- Host 1 management
        |               10.0.0.130
        |
        +---- Ethernet ---- Host 2 management
                            10.0.0.110

Host 1 Hyper-V
    |
    +---- VioletOps-WAN ---- OPNsense WAN
    |                        cable disconnected
    |
    +---- VioletOps-LAN ---- OPNsense LAN
                             10.10.10.1/24
                             DHCP 10.10.10.100–10.10.10.199

Host 2 Hyper-V
    |
    +---- Default Switch only
    +---- No VioletOps VMs
    +---- No custom lab networking
```

## Current Architecture Decision

- Host 1 remains the only active VioletOps workload host.
- Host 2 is verified as virtualization-ready but unassigned.
- No Host 2 VMs, custom virtual switches, VLANs, firewall rules, or static VioletOps IP addresses have been created.
- No inter-host lab network has been implemented.
- No storage partitions have been changed.
- OPNsense WAN validation remains paused until the dual-host physical baseline is complete.

## Design Decision Status

### Resolved During Phase 2.5

- Host 2 role: Core server and monitoring host
- Initial VM distribution across both hosts: Approved
- Host 2 Hyper-V storage design: Configured under `C:\HyperV`
- Monitor layout: Verified
- Cross-host mouse and clipboard control: Working through PowerToys Mouse Without Borders
- Host 2 USB Wi-Fi: Installed, connected, and verified
- Windows Server, Wazuh, and Splunk placement: Approved for Host 2
- Managed switch Port 2 assignment: Host 2 Ethernet

### Remaining Future Work

- Complete inter-host lab networking
- Finalize remaining managed-switch port assignments
- Configure VLANs and trunks
- Assign Host 2 a VioletOps lab IP
- Deploy the approved VMs
- Resume OPNsense WAN validation
## Verified Host Capacity

### Host 1 — DESKTOP-BG2AKA3

- Total physical memory: 31.79 GB
- C: capacity: 780.50 GB
- C: free space: 698.53 GB
- V: capacity: 150.00 GB
- V: free space: 138.18 GB

### Host 2 — DESKTOP-OD4CHNC

- Total physical memory: 31.78 GB
- C: capacity: 952.93 GB
- C: free space: 889.97 GB

### Capacity Decision

- Both hosts have approximately 32 GB RAM.
- Host 2 currently has more available VM storage.
- VM placement must reserve enough memory for each Windows host operating system.
- Initial VM workload placement has been approved; deployment remains pending.

## Approved Initial VM Placement

### Host 1 — Network and Test Endpoints

- `OPNsense-Gateway`
  - Memory: 4 GB
  - Role: Firewall, routing, DHCP, NAT, and network policy
- Windows 11 client
  - Planned memory: 6 GB
  - Role: Domain client, monitored endpoint, and Atomic Red Team target
- Kali Linux
  - Planned memory: 4 GB
  - Role: Controlled attack and validation system
- Lightweight utility VM
  - Status: Optional
  - Use only when required

### Host 2 — Core Server and Monitoring Services

- Windows Server / Active Directory
  - Planned memory: 4–6 GB
  - Role: Domain controller, DNS, users, groups, and Group Policy
- Wazuh server
  - Planned memory: 8 GB
  - Role: Endpoint monitoring, alerting, and security analytics
- Splunk server
  - Planned memory: 6–8 GB
  - Role: Log ingestion, searching, dashboards, and investigations

### Placement Decisions

- Atomic Red Team will run inside the Windows client and will not require a separate VM.
- Security Onion is deferred.
- Security Onion may be tested later only when other memory-heavy monitoring VMs are powered off.
- Both Windows host operating systems must retain enough RAM for stable operation.
- VM memory values are initial planning values and will be verified during deployment.
- No VMs were created during this design step.

## Host 2 Hyper-V Storage Design

- Host: `DESKTOP-OD4CHNC`
- Storage volume: `C:`
- Virtual machine configuration path:
  - `C:\HyperV\Virtual Machines`
- Virtual hard disk path:
  - `C:\HyperV\Virtual Hard Disks`
- Existing VMs during change: 0
- Migration required: No
- Storage path status: Configured and verified
- Future Host 2 VMs will use these default paths unless a VM-specific path is documented.

## Host 2 Network Adapter Baseline

- Host: `DESKTOP-OD4CHNC`

### Physical Ethernet

- Adapter name: `Ethernet`
- Interface: Intel(R) Ethernet Connection (7) I219-LM
- Status: Up
- Link speed: 1 Gbps
- MAC address: `E4-54-E8-96-76-5C`
- Current role: Available for future lab networking; no longer the active management connection
- Previous management IPv4 address: `10.0.0.110`

### USB Wi-Fi

- Adapter name: `Wi-Fi 2`
- Interface: Realtek RTL8811AU Wireless LAN 802.11ac USB 2.0 Network Adapter
- Status: Disconnected
- MAC address: `E8-4E-06-7C-EA-2E`
- Current role: Host 2 management connection
- Current management IPv4 address: `10.0.0.226`

### Hyper-V Virtual Adapter

- Adapter name: `vEthernet (Default Switch)`
- Status: Up
- Link speed reported: 10 Gbps
- MAC address: `00-15-5D-20-74-F3`
- Current role: Hyper-V Default Switch only

### Network Design Status

- No Host 2 physical adapter has been assigned to a custom Hyper-V external switch.
- Host 2 Ethernet must remain available for management until inter-host networking is approved and tested.
- No IP address, VLAN, firewall rule, or routing change was made during this verification.

## Managed Switch Physical Baseline

- Device: TP-Link TL-SG108E
- Current power state: Unplugged
- Current location: Stored on shelf
- Connected Ethernet ports: None
- Active VLAN configuration: Not verified
- Active port assignments: None
- Current role in VioletOps: Not deployed

### Change Control

- No inter-host lab connection currently exists.
- No switch port, VLAN, trunk, mirror, WAN, or management assignment has been made.
- The switch will remain disconnected until the physical port design is approved.

## Cross-Host Management and Control

### Host 1

- Management interface: `Wi-Fi`
- Management IPv4 address: `10.0.0.130`
- Network profile: Private

### Host 2

- Management interface: `Wi-Fi 2`
- Management IPv4 address: `10.0.0.226`
- Network profile: Private
- Ethernet is no longer the active management path.

### Mouse Without Borders

- Mouse movement between both monitors: Working
- Cross-PC clipboard copy and paste: Working
- Session recovery method: PowerToys `Refresh connections`
- Firewall scope: Private profile only
- Public-network access: Not allowed

### Design Decision

- Host 2 Wi-Fi remains the management path.
- Host 2 Ethernet remains available for future VioletOps lab networking.

## Managed Switch Port Assignment — Port 2

- Switch: TP-Link TL-SG108E
- Switch port: 2
- Connected device: Host 2 `DESKTOP-OD4CHNC`
- Host interface: Intel(R) Ethernet Connection (7) I219-LM
- Physical link: Up
- Switch Port 2 LED: On
- Ethernet network profile: Unidentified network
- Automatic IPv4 address: `169.254.125.231`
- Default gateway: None
- DHCP server: None detected
- Current purpose: Isolated physical lab connection
- Host 2 management remains on Wi-Fi `10.0.0.226`
- No VLAN, static IP, firewall rule, route, or NAT rule has been configured for Port 2.





