# VioletOps Dual-Host Architecture

Status: Complete
Last Updated: August 10, 2026

## Scope

This document summarizes the final VioletOps dual-host architecture, including physical host roles, network design, VM placement, identity services, centralized logging, and the security operations capabilities added throughout the project.

## Host 1 — Network and Test Host

- Model: Dell OptiPlex 7070 Micro
- CPU: Intel Core i7-9700T
- RAM: 32 GB
- Storage: 1 TB NVMe SSD
- Operating system: Windows 11 Pro
- Hyper-V: Enabled
- Management connection: Wi-Fi
- VioletOps LAN connection: USB Ethernet through `VioletOps-LAN`
- VioletOps LAN host address: `<HOST-1-LAB-IP>/24`
- WAN connection: Built-in Ethernet through `VioletOps-WAN`
- Assigned VMs:
  - `OPNsense-Gateway`
  - `VioletOps-WIN11`
  - `VioletOps-KALI`
- Custom virtual switches:
  - `VioletOps-LAN` — External
  - `VioletOps-WAN` — External
- Primary role: Firewall, monitored endpoint, and controlled attack/testing systems

## Host 2 — Core Server and Monitoring Host

- Model: Dell OptiPlex 7070
- CPU: Intel Core i7-9700
- RAM: 32 GB
- Storage: 1 TB NVMe SSD
- Operating system: Windows 11 Pro 25H2
- Hyper-V: Enabled
- Management connection: Wi-Fi
- VioletOps LAN connection: Built-in Ethernet through `VioletOps-LAN`
- VioletOps LAN host address: `<HOST-2-LAB-IP>/24`
- Assigned VMs:
  - `VioletOps-DC01`
  - `VioletOps-WAZUH`
  - `VioletOps-SPLUNK`
- Custom virtual switch:
  - `VioletOps-LAN` — External
- Primary role: Identity, centralized logging, and security monitoring

## Shared Physical Infrastructure

- Managed switch: TP-Link TL-SG108E
- Dual-monitor workstation setup:
  - Dell P2419H connected to Host 1
  - Dell P2419H connected to Host 2
- Both physical hosts use Wi-Fi for host management while dedicated Ethernet interfaces carry the VioletOps WAN and LAN paths.

## Current Logical Topology

```text
Internet / Home Network
        |
        +---- Wi-Fi ---- Host 1 management
        |
        +---- Wi-Fi ---- Host 2 management
        |
        +---- Switch Port 1
                |
             VLAN 10
                |
        TP-Link TL-SG108E
                |
        Switch Port 3
                |
        Host 1 built-in Ethernet
                |
          VioletOps-WAN
                |
          OPNsense WAN


VioletOps LAN — VLAN 1
        |
        +---- OPNsense LAN — <OPNSENSE-LAN-IP>
        |
        +---- Host 1 USB Ethernet
        |       |
        |       +---- Switch Port 4
        |       +---- Host 1 VioletOps LAN — <HOST-1-LAB-IP>
        |       +---- VioletOps-WIN11 — <WIN11-IP>
        |       +---- VioletOps-KALI — <KALI-IP>
        |
        +---- Host 2 built-in Ethernet
                |
                +---- Switch Port 2
                +---- Host 2 VioletOps LAN — <HOST-2-LAB-IP>
                +---- VioletOps-DC01 — <DC01-IP>
                +---- VioletOps-WAZUH — <WAZUH-IP>
                +---- VioletOps-SPLUNK — <SPLUNK-IP>

```
## Current Architecture Decision

- VioletOps uses two Hyper-V hosts to distribute network, endpoint, identity, and monitoring workloads.
- Host 1 runs `OPNsense-Gateway`, `VioletOps-WIN11`, and `VioletOps-KALI`.
- Host 2 runs `VioletOps-DC01`, `VioletOps-WAZUH`, and `VioletOps-SPLUNK`.
- Both Windows hosts use Wi-Fi for host management.
- The wired Ethernet paths are reserved for the VioletOps WAN and LAN networks.
- VLAN 10 separates the OPNsense WAN path from the VioletOps LAN.
- The VioletOps LAN connects both Hyper-V hosts and all lab VMs through the TP-Link TL-SG108E managed switch.
- OPNsense provides the lab gateway, DHCP, NAT, and network policy.


## Final VM Placement

### Host 1 — Network and Test Systems

- `OPNsense-Gateway`
  - Memory: 4 GB
  - Role: Firewall, routing, DHCP, NAT, and network policy
- `VioletOps-WIN11`
  - Memory: 6 GB
  - Role: Domain workstation, monitored endpoint, and detection-validation target
- `VioletOps-KALI`
  - Memory: 4 GB
  - Role: Controlled attack simulation and security testing

### Host 2 — Identity and Monitoring Services

- `VioletOps-DC01`
  - Memory: 6 GB
  - Role: Active Directory Domain Services, DNS, users, groups, and Group Policy
- `VioletOps-WAZUH`
  - Memory: 8 GB
  - Role: Endpoint monitoring, alerting, and security analytics
- `VioletOps-SPLUNK`
  - Memory: 6 GB
  - Role: Centralized log ingestion, searching, detections, dashboards, and investigations

### Placement Decisions

- Host 1 keeps the firewall, monitored workstation, and attack system together while maintaining separate WAN and LAN paths.
- Host 2 carries the identity and monitoring services, distributing the heavier server workloads away from Host 1.
- The two-host design keeps enough physical-host resources available for stable Windows operation while allowing all six VioletOps VMs to run together.
- Security Onion remains deferred because its resource requirements would overlap with the existing Wazuh and Splunk monitoring stack.


## Managed Switch and VLAN Design

- Device: TP-Link TL-SG108E managed switch
- Port 1: Home-network/Xfinity upstream — VLAN 10 WAN
- Port 2: Host 2 built-in Ethernet — VLAN 1 VioletOps LAN
- Port 3: Host 1 built-in Ethernet — VLAN 10 WAN
- Port 4: Host 1 USB Ethernet — VLAN 1 VioletOps LAN
- VLAN 10 carries the OPNsense WAN path between the upstream network and Host 1.
- VLAN 1 carries the VioletOps LAN between OPNsense, both Hyper-V hosts, and the lab VMs.
- The WAN and VioletOps LAN paths remain logically separated on the managed switch.


## Identity and Policy Architecture

- Active Directory domain: `violetops.internal`
- Domain controller: `VioletOps-DC01`
- Organizational units separate administrators, groups, servers, users, and workstations.
- `VioletOps-WIN11` is managed through the Workstations OU.
- Standard and privileged accounts use separate security groups to support role separation.
- Domain password policy requires a minimum of 14 characters.
- Account lockout is triggered after 5 invalid attempts, with a 15-minute lockout and reset window.
- The VioletOps Workstation Security Baseline GPO enables:
  - PowerShell Script Block Logging
  - PowerShell Module Logging
  - Command-line logging for process creation
  - Successful process-creation auditing
- Domain members use `VioletOps-DC01` for centralized identity, DNS, Group Policy, and time synchronization.

## Centralized Logging Architecture

### Windows Telemetry

- Source: `VioletOps-WIN11`
- Forwarder: Splunk Universal Forwarder
- Destination: `VioletOps-SPLUNK`
- Transport: TCP 9997
- Collected telemetry:
  - Windows Security
  - PowerShell Operational
  - Sysmon Operational
- Splunk index: `main`

Data path:

`VioletOps-WIN11 -> Splunk Universal Forwarder -> TCP 9997 -> VioletOps-SPLUNK`

### OPNsense Firewall Telemetry

- Source: `OPNsense-Gateway`
- Destination: `VioletOps-SPLUNK`
- Transport: UDP 5514
- Splunk sourcetype: `opnsense:filterlog`

Data path:

`OPNsense-Gateway -> UDP 5514 -> VioletOps-SPLUNK`

### Monitoring Architecture

- Wazuh provides endpoint monitoring and security alerting for the Windows systems.
- Splunk provides centralized log ingestion, searching, detection engineering, dashboards, and investigation workflows.
- Together, Wazuh and Splunk provide complementary visibility across endpoint, authentication, network, PowerShell, Sysmon, and firewall telemetry.

## Security Operations Evolution — Phases 6–10

- Phase 6 added detection engineering using the telemetry collected by Wazuh and Splunk.
- Phase 7 introduced automation to support repeatable security operations workflows.
- Phase 8 used `VioletOps-KALI` and `VioletOps-WIN11` for controlled ATT&CK-aligned attack simulation and telemetry validation.
- Phase 9 used the collected alerts and telemetry for structured SOC investigations, triage, and case documentation.
- Phase 10 used purple-team testing to identify detection and telemetry gaps, improve visibility, tune detections, and retest the environment.


### Detection and Visibility Improvements

- Sysmon, Windows Security, PowerShell, firewall, and OPNsense telemetry were correlated across Splunk and Wazuh.
- Controlled T1046 Network Service Discovery and T1018 Remote System Discovery activity was used to validate detection coverage.
- Windows Defender Firewall successful-connection logging was added to improve visibility for ICMP discovery activity.
- Splunk Universal Forwarder collection was extended to ingest Windows Firewall telemetry using the `windows:firewall` sourcetype.
- Splunk detections were created and tuned for the tested discovery techniques.
- Retesting confirmed the improved telemetry and detection paths worked as intended.

## Remaining Future Work

- Expand visibility at the home-network edge beyond the VioletOps lab boundary.
- Evaluate centralized logging or monitoring for the home-network firewall/gateway device.
- Evaluate additional wireless access-point telemetry and visibility.
- Any future integration with home-network infrastructure will remain separate from the validated VioletOps lab until it is intentionally designed, tested, and documented.

The final VioletOps architecture supports controlled attack simulation, centralized telemetry collection, detection engineering, SOC investigation, and purple-team validation across the same isolated lab environment.
