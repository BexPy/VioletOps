# VioletOps VM Inventory

Status: Phase 3 Technical Deployment Complete
Last Updated: July 21, 2026

## Host 1 â€” Original VioletOps Hyper-V Host

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
- Operating system: OPNsense 26.1.11_10-amd64
- File system: ZFS
- WAN interface:
  - OPNsense device: `hn0`
  - MAC address: `<OPNSENSE-WAN-MAC>`
  - Hyper-V switch: `VioletOps-WAN`
  - Physical WAN cable: Connected through managed-switch VLAN 10
- LAN interface:
  - OPNsense device: `hn1`
  - MAC address: `<OPNSENSE-LAN-MAC>`
  - Hyper-V switch: `VioletOps-LAN`
  - IPv4 address: `<OPNSENSE-LAN-IP>/24`
  - DHCP range: `<VIOLETOPS-DHCP-START>â€“<VIOLETOPS-DHCP-END>`
- Web GUI: `https://<OPNSENSE-LAN-IP>`
- Current phase: Phase 2 OPNsense firewall configuration and validation completed

## Host 2 â€” <HOST-2-NAME>

- Hyper-V status: Enabled and verified
- Existing virtual machines: 0
- Assigned VioletOps virtual machines: None
- Custom virtual switches: None
- Built-in virtual switches:
  - `Default Switch` â€” Internal
- VM workload role: Core server and monitoring host
- VM storage design: Configured and verified under `C:\HyperV`

## Placement Status

Initial VM placement has been approved, but no additional Windows, Linux, SIEM, Active Directory, or attack-simulation VMs have been created yet.

## Approved Planned VM Placement

### Host 1 â€” Planned

- Windows 11 client
  - Planned memory: 6 GB
  - Purpose: Domain client, monitored endpoint, and Atomic Red Team target
  - Deployment status: Not created
- Kali Linux
  - Planned memory: 4 GB
  - Purpose: Controlled attack and validation system
  - Deployment status: Not created

### Host 2 â€” Planned

- Windows Server / Active Directory
  - Planned memory: 4â€“6 GB
  - Purpose: Domain controller, DNS, users, groups, and Group Policy
  - Deployment status: Not created
- Wazuh server
  - Planned memory: 8 GB
  - Purpose: Endpoint monitoring, alerting, and security analytics
  - Deployment status: Not created
- Splunk server
  - Planned memory: 6â€“8 GB
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

- Host: `<HOST-2-NAME>`
- Default VM configuration path:
  - `C:\HyperV\Virtual Machines`
- Default virtual disk path:
  - `C:\HyperV\Virtual Hard Disks`
- Planned Windows Server, Wazuh, and Splunk VMs will use these paths unless a different path is documented.
- Current Host 2 VM count: 0
- Storage assignment status: Configured and verified


## OPNsense WAN Validation

- VM: OPNsense-Gateway
- Host: Host 1
- Status: Running
- WAN switch: VioletOps-WAN
- LAN switch: VioletOps-LAN
- WAN addressing: Upstream DHCP
- WAN internet test: Passed
- DNS resolution test: Passed
- Firewall and NAT baseline validation: Completed



## OPNsense Firewall Validation Status

- Default LAN rules: Reviewed
- WAN rules: Empty baseline verified
- Automatic outbound NAT: Verified
- LAN-to-WAN forwarding: Passed
- Temporary test route: Removed
- Permanent routing changes: None





## Phase 3 Hyper-V Host Capacity Baseline â€” 2026-07-17

### Host 1 â€” <HOST-1-NAME>

- Hardware: Dell OptiPlex 7070
- Processor: Intel Core i7-9700T
- CPU capacity: 8 cores / 8 logical processors
- Installed memory: 32 GB
- Hyper-V VM storage volume: V:
- Storage capacity: approximately 150 GB
- Free space at baseline: approximately 136.66 GB
- Default VM configuration path:
  - V:\HyperV-VMs\Virtual Machines
- Default virtual disk path:
  - V:\HyperV-VMs\Virtual Hard Disks
- Existing VM:
  - Name: OPNsense-Gateway
  - State: Running
  - Generation: 1
  - Virtual processors: 2
  - Startup memory: 4 GB static
  - Virtual disk: V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx
- Virtual switches:
  - VioletOps-WAN â€” External
  - VioletOps-LAN â€” Internal
  - Default Switch â€” Internal
- Approved role: Gateway, network edge, Windows 11 client, and Kali Linux host

### Host 2 â€” <HOST-2-NAME>

- Hardware: Dell OptiPlex 7070
- Processor: Intel Core i7-9700
- CPU capacity: 8 cores / 8 logical processors
- Installed memory: 32 GB
- Hyper-V VM storage volume: C:
- Storage capacity: approximately 952.83 GB
- Free space at baseline: approximately 890.44 GB
- Default VM configuration path:
  - C:\HyperV\Virtual Machines
- Default virtual disk path:
  - C:\HyperV\Virtual Hard Disks
- Existing VMs: None
- Virtual switches:
  - Default Switch â€” Internal
- Approved role: Windows Server / Active Directory, Wazuh, and Splunk host

### Capacity Controls

- Host 1 retains OPNsense as its required always-on workload.
- Host 2 carries the larger server and monitoring workloads because it has substantially more available storage.
- VM memory values remain initial deployment targets and must be verified during each build.
- Inter-host VioletOps networking must be completed before Host 2 production lab VMs are deployed.
- Security Onion remains deferred.
- No VM, IP address, VLAN, route, firewall rule, NAT rule, or virtual-switch configuration was changed during this documentation reconciliation.
- GitHub documentation remains unchanged pending the separate sanitization review.

### Host 1 Storage Preparation â€” 2026-07-19

- New Host 1 storage structure:
  - VM configuration folder: C:\HyperV\Virtual Machines
  - Virtual disk folder: C:\HyperV\Virtual Hard Disks
- Intended future workloads: Windows 11 client and Kali Linux.
- Existing OPNsense VM and VHDX remain on V:.
- Hyper-V defaults remain unchanged pending separate configuration and verification.
- No new VM was created.

### Host 1 Storage Assignment â€” 2026-07-19

- Default VM configuration path: `C:\HyperV\Virtual Machines`
- Default virtual disk path: `C:\HyperV\Virtual Hard Disks`
- Planned workloads using these defaults: Windows 11 client and Kali Linux.
- OPNsense remains stored separately on `V:`.
- No new VM was created and no existing VM was moved.

## Verified Phase 3 Deployment Allocation â€” 2026-07-19

| Host | VM | RAM | vCPU | Maximum Dynamic VHDX | Planned IP | Status |
|---|---|---:|---:|---:|---|---|
| Host 1 | OPNsense-Gateway | 4 GB | 2 | 25 GB | <OPNSENSE-LAN-IP> | Running |
| Host 1 | Windows 11 client | 6 GB | 2 | 64 GB | <WIN11-IP> | Not created |
| Host 1 | Kali Linux | 4 GB | 2 | 40 GB | <KALI-IP> | Not created |
| Host 2 | Windows Server / AD / DNS | 6 GB | 2 | 80 GB | <DC01-IP> | Not created |
| Host 2 | Wazuh | 8 GB | 4 | 120 GB | <WAZUH-IP> | Not created |
| Host 2 | Splunk | 6 GB | 2 | 100 GB | <SPLUNK-IP> | Not created |

- Host 1 future VM defaults: `C:\HyperV`
- Host 2 VM defaults: `C:\HyperV`
- Security Onion remains deferred.
- Allocations are approved initial values and remain subject to post-deployment performance validation.

### Windows Server Installation Media â€” 2026-07-19

- Host: Host 2 (`<HOST-2-NAME>`)
- Product: Windows Server 2025 Evaluation
- Architecture: x64
- Language: English (United States)
- ISO path: `C:\VioletOps\ISO\26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso`
- ISO size: 7.592 GB
- SHA-256: `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51`
- Hash verification result: Passed
- ISO has not been mounted or used to create a VM yet.

### Windows 11 Installation Media â€” 2026-07-19

- Host: Host 1 (`<HOST-1-NAME>`)
- Product: Windows 11 25H2 multi-edition
- Architecture: x64
- Language: English
- ISO path: `C:\VioletOps\ISO\Win11_25H2_English_x64_v2.iso`
- ISO size: 7.890 GB
- SHA-256: `768984706B909479417B2368438909440F2967FF05C6A9195ED2667254E465E3`
- Hash verification result: Passed
- ISO has not been mounted or used to create a VM yet.

### Kali Linux Installation Media â€” 2026-07-19

- Host: Host 1 (`<HOST-1-NAME>`)
- Product: Kali Linux 2026.2 Installer
- Architecture: amd64
- ISO path: `C:\VioletOps\ISO\kali-linux-2026.2-installer-amd64.iso`
- ISO size: 4.473 GB
- SHA-256: `6DBEFACC95E3B556C19C48E8BAE39B8B505E2D3A1ABA0BFB7AB62B036C3D2BA3`
- Official Kali checksum comparison: Passed
- Final-location hash comparison: Passed
- ISO has not been mounted or used to create a VM yet.

### Ubuntu Server Installation Media â€” 2026-07-19

- Host: Host 2 (`<HOST-2-NAME>`)
- Product: Ubuntu Server 22.04.5 LTS
- Architecture: amd64
- ISO path: `C:\VioletOps\ISO\ubuntu-22.04.5-live-server-amd64.iso`
- ISO size: 1.990 GB
- SHA-256: `9BC6028870AEF3F74F4E16B900008179E78B130E6B0B9A140635434A46AA98B0`
- Official Ubuntu checksum comparison: Passed
- Planned use: Wazuh and Splunk server VMs
- ISO has not been mounted or used to create a VM yet.

## Phase 3 Final Installation Media Baseline â€” 2026-07-19

### Host 1 â€” <HOST-1-NAME>

- Kali Linux 2026.2 Installer: `C:\VioletOps\ISO\kali-linux-2026.2-installer-amd64.iso`
- Windows 11 25H2: `C:\VioletOps\ISO\Win11_25H2_English_x64_v2.iso`
- OPNsense 26.1.6 copy: `C:\VioletOps\ISO\OPNsense-26.1.6-dvd-amd64 (1).iso`
- OPNsense 26.1.6 original: `V:\ISO_Reps\OPNsense-26.1.6-dvd-amd64.iso`
- Ubuntu Server 22.04.5 reference copy: `V:\ISO_Reps\ubuntu-22.04.5-live-server-amd64.iso`
- Both OPNsense files have matching SHA-256 hashes and are verified duplicates.

### Host 2 â€” <HOST-2-NAME>

- Windows Server 2025 Evaluation: `C:\VioletOps\ISO\26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso`
- Ubuntu Server 22.04.5 LTS: `C:\VioletOps\ISO\ubuntu-22.04.5-live-server-amd64.iso`

- All required Phase 3 installation media is present and hash verified.
- No incomplete ISO files remain.
- No ISO has been mounted or used to create a new VM yet.

## Phase 3 Deployed VM - VioletOps-DC01 - 2026-07-19

- Hyper-V host: `<HOST-2-NAME>`
- VM name: `VioletOps-DC01`
- State at verification: Running
- Generation: 2
- Processor count: 2 vCPU
- Startup memory: 6 GB static
- Checkpoints: Disabled
- VM configuration path: `C:\HyperV\Virtual Machines`
- VHDX path: `C:\HyperV\Virtual Hard Disks\VioletOps-DC01.vhdx`
- VHDX type: Dynamic
- Maximum VHDX size: 80 GB
- Disk controller: SCSI 0, location 0
- Virtual switch: `VioletOps-LAN`
- Virtual NIC status: OK
- MAC address: `<DC01-MAC>`
- Operating system: Windows Server 2025 Standard Evaluation Desktop Experience
- Computer name: `VIOLETOPS-DC01`
- Static IPv4 address: `<DC01-IP>/24`
- Default gateway: `<OPNSENSE-LAN-IP>`
- Active Directory forest and DNS domain: `violetops.internal`
- NetBIOS domain: `VIOLETOPS`
- Roles: Active Directory Domain Services and DNS Server
- Domain-controller diagnostics: Passed
- Time zone: Central Standard Time
- External NTP peers: `time.cloudflare.com` and `time.google.com`
- Verified active time source: `time.google.com`
- Hyper-V Time Synchronization integration service: Disabled
- Windows Server installation media has now been used to deploy this VM
- GitHub documentation was not updated or pushed pending sanitization review

## Phase 3 Deployed VM - VioletOps-WIN11 - 2026-07-20

- Hyper-V host: `<HOST-1-NAME>`
- VM name: `VioletOps-WIN11`
- Computer name: `VIOLETOPS-WIN11`
- State at verification: Running
- Generation: 2
- Processor count: 2 vCPU
- Startup memory: 6 GB static
- Dynamic Memory: Disabled
- Checkpoints: Disabled
- VM configuration path: `C:\HyperV\Virtual Machines`
- VHDX path: `C:\HyperV\Virtual Hard Disks\VioletOps-WIN11.vhdx`
- VHDX type: Dynamic
- Maximum VHDX size: 64 GB
- Disk controller: SCSI 0, location 0
- Virtual switch: `VioletOps-LAN`
- Virtual NIC status: Up
- MAC address: `<WIN11-MAC>`
- Operating system: Windows 11 Pro 25H2
- Verified OS version and build: `10.0.26200`
- Static IPv4 address: `<WIN11-IP>/24`
- Default gateway: `<OPNSENSE-LAN-IP>`
- DNS server: `<DC01-IP>`
- Domain: `violetops.internal`
- Verified domain sign-in: `VIOLETOPS\Administrator`
- Domain secure channel: Healthy
- Group Policy source: `VIOLETOPS-DC01.violetops.internal`
- Windows Time source: `VIOLETOPS-DC01.violetops.internal`
- Hyper-V Time Synchronization integration service: Disabled
- Secure Boot: Enabled
- Virtual TPM: Enabled
- Windows 11 installation media has now been used to deploy this VM
- Installation ISO detached after deployment
- Virtual hard disk set as first boot device
- Controlled restart and post-restart domain validation passed
- GitHub documentation was not updated or pushed pending sanitization review

## Post-Rewire VM Recovery Validation â€” 2026-07-20

- OPNsense-Gateway started successfully and reported Operating normally.
- OPNsense LAN address <OPNSENSE-LAN-IP> responded with 0% packet loss.
- VioletOps-DC01 started successfully and reported Operating normally.
- Domain controller address <DC01-IP> responded with 0% packet loss.
- VioletOps-WIN11 started successfully and reported Operating normally.
- Windows 11 Hyper-V heartbeat status: OK.
- Windows 11 address: <WIN11-IP>/24.
- Windows 11 network profile: DomainAuthenticated.
- Windows 11 IPv4 connectivity: Internet.
- Windows 11 firewall rule added:
  - Display name: VioletOps LAN - Allow ICMPv4 Echo
  - Direction: Inbound
  - Protocol: ICMPv4
  - ICMP type: Echo Request
  - Remote network: <VIOLETOPS-LAN>
  - Interface: Ethernet
  - Profile: Domain
  - Action: Allow
- Windows 11 connectivity verified from Host 1 with 0% packet loss.
- No OPNsense, NAT, DHCP, VLAN, physical-switch, or virtual-switch configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## Phase 3 Kali Linux Deployment â€” 2026-07-20

- VM name: VioletOps-KALI
- Hyper-V host: <HOST-1-NAME>
- Generation: 2
- vCPU: 2
- Memory: 4 GB static
- Virtual disk: 40 GB dynamically expanding
- Virtual disk path: C:\HyperV\Virtual Hard Disks\VioletOps-KALI.vhdx
- VM configuration path: C:\HyperV\Virtual Machines\VioletOps-KALI
- Virtual switch: VioletOps-LAN
- Operating system: Kali GNU/Linux Rolling
- Verified release: 2026.2
- Hostname: violetops-kali
- Domain suffix: violetops.internal
- Network interface: eth0
- MAC address: <KALI-MAC>
- Static IPv4 address: <KALI-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- OPNsense gateway connectivity verified with 0% packet loss.
- Outbound IPv4 connectivity to 1.1.1.1 verified with 0% packet loss.
- DNS resolution for kali.org verified.
- Static IP, gateway, and DNS configuration persisted after reboot.
- Secure Boot: Disabled because the Kali installer image was not accepted by Hyper-V Secure Boot.
- Checkpoints: Disabled
- Installation ISO detached after deployment.
- Virtual hard disk set as first boot device.
- Clean boot from the installed virtual disk verified.
- No OPNsense, NAT, DHCP, VLAN, physical-switch, virtual-switch, or firewall configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## Phase 3 Wazuh Deployment â€” 2026-07-21

- VM name: VioletOps-WAZUH
- Hyper-V host: <HOST-2-NAME>
- Generation: 2
- vCPU: 4
- Memory: 8 GB static
- Virtual disk: 120 GB dynamically expanding
- Virtual disk path: C:\HyperV\Virtual Hard Disks\VioletOps-WAZUH.vhdx
- VM configuration path: C:\HyperV\Virtual Machines\VioletOps-WAZUH
- Virtual switch: VioletOps-LAN
- Operating system: Ubuntu Server 22.04.5 LTS
- Hostname: wazuh
- Domain suffix: violetops.internal
- Network interface: eth0
- MAC address: <WAZUH-MAC>
- Static IPv4 address: <WAZUH-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- Wazuh version: 4.14.6-1
- Deployment type: All-in-one
- Active services: wazuh-manager, wazuh-indexer, wazuh-dashboard, filebeat
- Dashboard: https://<WAZUH-IP>
- Indexer cluster status: Green
- Dashboard access from WIN11 <WIN11-IP> verified on TCP 443.
- Agent communication TCP 1514 and enrollment TCP 1515 verified listening.
- Wazuh API TCP 55000 verified.
- Checkpoints: Disabled
- Installation ISO detached after deployment.
- No OPNsense, NAT, DHCP, VLAN, physical-switch, virtual-switch, or firewall configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## Phase 3 Splunk Deployment - 2026-07-21

- VM name: VioletOps-SPLUNK
- Hyper-V host: <HOST-2-NAME>
- Generation: 2
- vCPU: 2
- Memory: 6 GB static
- Dynamic Memory: Disabled
- Virtual disk: 100 GB dynamically expanding
- Virtual disk path: C:\HyperV\Virtual Hard Disks\VioletOps-SPLUNK.vhdx
- Current virtual disk file size: Approximately 19.63 GB
- VM configuration path: C:\HyperV\Virtual Machines\VioletOps-SPLUNK\VioletOps-SPLUNK
- Virtual switch: VioletOps-LAN
- Operating system: Ubuntu Server 22.04.5 LTS
- Kernel: 5.15.0-186-generic
- Hostname: violetops-splunk
- Domain suffix: violetops.internal
- Network interface: eth0
- MAC address: <SPLUNK-MAC>
- Static IPv4 address: <SPLUNK-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- Splunk Enterprise version: 10.4.1
- Splunk installation path: /opt/splunk
- Splunk service account: splunk
- Splunk Web: http://<SPLUNK-IP>:8000
- Splunk management API: TCP 8089
- Initial monitored source: /var/log/syslog
- Effective index: main
- Sourcetype: linux_messages_syslog
- Source host value: violetops-splunk
- Syslog indexing and current event ingestion verified.
- Splunk boot-start enabled and verified after reboot.
- Ubuntu root filesystem: 95 GB total, approximately 79 GB available at verification.
- Ubuntu UFW status: Inactive
- Automatic checkpoint removed.
- Automatic checkpoints: Disabled
- Installation ISO detached after deployment.
- Ubuntu package baseline verified fully up to date.
- No OPNsense, NAT, DHCP, VLAN, routing, physical-switch, virtual-switch, or firewall configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## Phase 4 VM Inventory Status — 2026-07-23

- No virtual machines were created, deleted, moved, resized, or reconfigured during Phase 4.
- Existing VM placement remains unchanged:
  - Host 1: OPNsense-Gateway, VioletOps-KALI, VioletOps-WIN11
  - Host 2: VioletOps-DC01, VioletOps-WAZUH, VioletOps-SPLUNK
- VioletOps-WIN11 remains the domain workstation used for standard-user, privileged-user, Group Policy, process-auditing, and failed-logon testing.
- VioletOps-DC01 remains the Active Directory domain controller and source of account-lockout Event ID 4740.
- VioletOps-WAZUH remains the security-monitoring server receiving Windows telemetry.
- No CPU, memory, storage, MAC address, IP address, virtual-switch, checkpoint, or host-placement changes occurred.

## Phase 5 Centralized Logging Inventory Update - 2026-07-25

### VioletOps-WIN11

- Installed Splunk Universal Forwarder 10.4.1.
- SplunkForwarder service configured for automatic startup.
- Forwarding connection to VioletOps-SPLUNK verified active over TCP 9997.
- Forwarded Windows event channels:
  - Security
  - Microsoft-Windows-PowerShell/Operational
  - Microsoft-Windows-Sysmon/Operational
- Splunk service account granted local Event Log Readers access for Sysmon collection.
- Security, PowerShell, and Sysmon telemetry verified after controlled reboot.

### VioletOps-SPLUNK

- Splunk Enterprise 10.4.1 remained the installed version.
- TCP 9997 listener enabled for Windows Universal Forwarder traffic.
- UDP 5514 listener enabled for OPNsense firewall filter logs.
- Windows and OPNsense telemetry verified after controlled reboot.

### VM Change Summary

- No VM was created, deleted, moved, resized, or reconfigured.
- No CPU, memory, disk, MAC address, IP address, virtual-switch, checkpoint, or host-placement change occurred.
