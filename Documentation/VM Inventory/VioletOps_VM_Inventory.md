# VioletOps VM Inventory

Status: Complete
Last Updated: August 10, 2026

## Current VM Placement

### Host 1 — Network and Test Systems

- `OPNsense-Gateway`
  - Memory: 4 GB
  - vCPU: 2
  - Operating system: OPNsense 26.1.11_10-amd64
  - Role: Firewall, routing, DHCP, NAT, and network policy
  - Status: Deployed and validated
- `VioletOps-WIN11`
  - Memory: 6 GB
  - vCPU: 2
  - Role: Domain workstation, monitored endpoint, and detection-validation target
  - Status: Deployed and validated
- `VioletOps-KALI`
  - Memory: 4 GB
  - vCPU: 2
  - Role: Controlled attack simulation and security testing
  - Status: Deployed and validated

### Host 2 — Identity and Monitoring Services

- `VioletOps-DC01`
  - Memory: 6 GB
  - vCPU: 2
  - Role: Active Directory Domain Services, DNS, users, groups, and Group Policy
  - Status: Deployed and validated
- `VioletOps-WAZUH`
  - Memory: 8 GB
  - vCPU: 4
  - Role: Endpoint monitoring, alerting, and security analytics
  - Status: Deployed and validated
- `VioletOps-SPLUNK`
  - Memory: 6 GB
  - vCPU: 2
  - Role: Centralized log ingestion, searching, detections, dashboards, and investigations
  - Status: Deployed and validated

## Deferred Workloads

- Security Onion remains deferred because its resource requirements overlap with the existing Wazuh and Splunk monitoring stack.

## VM Storage

- Host 1 default VM configuration path: `C:\HyperV\Virtual Machines`
- Host 1 default virtual disk path: `C:\HyperV\Virtual Hard Disks`
- `OPNsense-Gateway` remains stored separately under `V:\HyperV-VMs`.
- Host 2 default VM configuration path: `C:\HyperV\Virtual Machines`
- Host 2 default virtual disk path: `C:\HyperV\Virtual Hard Disks`


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





## Phase 3 Hyper-V Host Capacity Baseline — 2026-07-17

### Host 1 — <HOST-1-NAME>

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
  - VioletOps-WAN — External
  - VioletOps-LAN — Internal
  - Default Switch — Internal
- Approved role: Gateway, network edge, Windows 11 client, and Kali Linux host

### Host 2 — <HOST-2-NAME>

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
  - Default Switch — Internal
- Approved role: Windows Server / Active Directory, Wazuh, and Splunk host

### Capacity Controls

- VM memory allocations were validated during deployment and remain appropriate for the current lab design.
- Host 1 and Host 2 are connected through the completed VioletOps LAN.
- Security Onion remains deferred.
- No VM, IP address, VLAN, route, firewall rule, NAT rule, or virtual-switch configuration was changed during this documentation reconciliation.
- GitHub documentation has been sanitized and reconciled with the final validated lab state.

### Windows Server Installation Media — 2026-07-19

- Host: Host 2 (`<HOST-2-NAME>`)
- Product: Windows Server 2025 Evaluation
- Architecture: x64
- Language: English (United States)
- ISO path: `C:\VioletOps\ISO\26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso`
- ISO size: 7.592 GB
- SHA-256: `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51`
- Hash verification result: Passed
- Deployment status: Used for the completed `VioletOps-DC01` deployment.

### Windows 11 Installation Media — 2026-07-19

- Host: Host 1 (`<HOST-1-NAME>`)
- Product: Windows 11 25H2 multi-edition
- Architecture: x64
- Language: English
- ISO path: `C:\VioletOps\ISO\Win11_25H2_English_x64_v2.iso`
- ISO size: 7.890 GB
- SHA-256: `768984706B909479417B2368438909440F2967FF05C6A9195ED2667254E465E3`
- Hash verification result: Passed
- Deployment status: Used for the completed `VioletOps-WIN11` deployment.


### Kali Linux Installation Media — 2026-07-19

- Host: Host 1 (`<HOST-1-NAME>`)
- Product: Kali Linux 2026.2 Installer
- Architecture: amd64
- ISO path: `C:\VioletOps\ISO\kali-linux-2026.2-installer-amd64.iso`
- ISO size: 4.473 GB
- SHA-256: `6DBEFACC95E3B556C19C48E8BAE39B8B505E2D3A1ABA0BFB7AB62B036C3D2BA3`
- Official Kali checksum comparison: Passed
- Final-location hash comparison: Passed
- Deployment status: Used for the completed `VioletOps-KALI` deployment.


### Ubuntu Server Installation Media — 2026-07-19

- Host: Host 2 (`<HOST-2-NAME>`)
- Product: Ubuntu Server 22.04.5 LTS
- Architecture: amd64
- ISO path: `C:\VioletOps\ISO\ubuntu-22.04.5-live-server-amd64.iso`
- ISO size: 1.990 GB
- SHA-256: `9BC6028870AEF3F74F4E16B900008179E78B130E6B0B9A140635434A46AA98B0`
- Official Ubuntu checksum comparison: Passed
- Use: Deployment media for `VioletOps-WAZUH` and `VioletOps-SPLUNK`
- Deployment status: Used for the completed Wazuh and Splunk server deployments.

## Phase 3 Final Installation Media Baseline — 2026-07-19

### Host 1 — <HOST-1-NAME>

- Kali Linux 2026.2 Installer: `C:\VioletOps\ISO\kali-linux-2026.2-installer-amd64.iso`
- Windows 11 25H2: `C:\VioletOps\ISO\Win11_25H2_English_x64_v2.iso`
- OPNsense 26.1.6 copy: `C:\VioletOps\ISO\OPNsense-26.1.6-dvd-amd64 (1).iso`
- OPNsense 26.1.6 original: `V:\ISO_Reps\OPNsense-26.1.6-dvd-amd64.iso`
- Ubuntu Server 22.04.5 reference copy: `V:\ISO_Reps\ubuntu-22.04.5-live-server-amd64.iso`
- Both OPNsense files have matching SHA-256 hashes and are verified duplicates.

### Host 2 — <HOST-2-NAME>

- Windows Server 2025 Evaluation: `C:\VioletOps\ISO\26100.32230.260111-0550.lt_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso`
- Ubuntu Server 22.04.5 LTS: `C:\VioletOps\ISO\ubuntu-22.04.5-live-server-amd64.iso`

- All required Phase 3 installation media is present and hash verified.
- No incomplete ISO files remain.
- Deployment status: Installation media was used for the completed `VioletOps-DC01`, `VioletOps-WAZUH`, and `VioletOps-SPLUNK` deployments.


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

## Post-Rewire VM Recovery Validation — 2026-07-20

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


## Phase 3 Kali Linux Deployment — 2026-07-20

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


## Phase 3 Wazuh Deployment — 2026-07-21

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

## Phase 10 Section 8 - Detection Engineering Inventory Update - 2026-08-08

### VioletOps-WIN11

- Windows Defender Firewall Domain profile remains enabled.
- Successful-connection logging was enabled to provide telemetry for controlled ICMP discovery activity.
- The existing inbound ICMPv4 Echo Request rule remained restricted to the approved Kali source.
- Splunk Universal Forwarder was extended to collect the Windows Firewall log.
- Firewall telemetry is forwarded to the existing VioletOps-SPLUNK receiver over TCP 9997.
- Effective Splunk index: `main`.
- Firewall telemetry sourcetype: `windows:firewall`.
- SplunkForwarder service was restarted and verified operational after the collection change.

### VioletOps-SPLUNK

- Existing Splunk Enterprise deployment and TCP 9997 receiving service remain unchanged.
- Windows Firewall telemetry from VioletOps-WIN11 is indexed successfully.
- Scenario 2 detection: `VioletOps - T1018 Remote System Discovery`.
- Runtime validation confirmed successful detection and creation of a Splunk Triggered Alerts entry.

### VM Change Summary

- No VM was created, deleted, moved, resized, restored, or checkpointed.
- No CPU, memory, disk, MAC address, IP address, virtual-switch assignment, or host placement changed.
- Changes were limited to endpoint firewall logging, log collection, and Splunk detection engineering.
- Phase 10 is technically validated, documented, published, and fully complete.
