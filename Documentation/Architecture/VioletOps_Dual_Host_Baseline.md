# VioletOps Dual-Host Baseline Architecture

Status: In Progress  
Last Updated: July 11, 2026

## Scope

This document records the verified physical and virtualization baseline for the two-host VioletOps lab before Host 2 workload placement, storage redesign, monitor integration, or OPNsense WAN validation.

## Host 1 â€” Original VioletOps Hyper-V Host

- Model: Dell OptiPlex 7070 Micro
- CPU: Intel Core i7-9700
- RAM: 32 GB
- Storage: 1 TB NVMe SSD
- Operating system: Windows 11 Pro
- Hyper-V: Enabled
- Management connection: Wi-Fi
- Management IPv4 address: `<HOST-1-MANAGEMENT-IP>`
- VioletOps LAN host address: `<HOST-1-LAB-IP>/24`
- Current assigned VM:
  - `OPNsense-Gateway`
- Current custom virtual switches:
  - `VioletOps-LAN` â€” Internal
  - `VioletOps-WAN` â€” External
- Physical Ethernet role:
  - Dedicated to `VioletOps-WAN`
- OPNsense WAN physical path:
  - Connected through TP-Link TL-SG108E VLAN 10
  - Upstream gateway Port 1 -> switch Port 1 -> switch Port 3 -> Host 1 Ethernet -> VioletOps-WAN -> OPNsense WAN
  - WAN DHCP and outbound connectivity verified

## Host 2 â€” <HOST-2-NAME>

- Model: Dell OptiPlex 7070
- CPU: Intel Core i7-9700
- RAM: 32 GB
- Storage: 1 TB SK hynix PC801 NVMe SSD
- Operating system: Windows 11 Pro 25H2
- Hyper-V: Enabled and verified
- Current management connection: Ethernet directly to router
- Current management IPv4 address: `<HOST-2-MANAGEMENT-IP>`
- Ethernet MAC address: `<HOST-2-ETHERNET-MAC>`
- Ethernet link speed: 1 Gbps
- Existing virtual machines: 0
- Custom virtual switches: 0
- Built-in virtual switches:
  - `Default Switch` â€” Internal
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
        |               <HOST-1-MANAGEMENT-IP>
        |
        +---- Ethernet ---- Host 2 management
                            <HOST-2-PREVIOUS-MANAGEMENT-IP>

Host 1 Hyper-V
    |
    +---- VioletOps-WAN ---- OPNsense WAN
    |                        <OPNSENSE-WAN-DHCP-IP> via DHCP
    |                        connected through TP-Link VLAN 10
    |
    +---- VioletOps-LAN ---- OPNsense LAN
                             <OPNSENSE-LAN-IP>/24
                             DHCP <VIOLETOPS-DHCP-START>â€“<VIOLETOPS-DHCP-END>
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
- OPNsense WAN validation is complete.
- WAN DHCP, outbound IPv4 connectivity, DNS resolution, automatic outbound NAT, and LAN-to-WAN forwarding were verified.

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

## Verified Host Capacity

### Host 1 â€” <HOST-1-NAME>

- Total physical memory: 31.79 GB
- C: capacity: 780.50 GB
- C: free space: 698.53 GB
- V: capacity: 150.00 GB
- V: free space: 138.18 GB

### Host 2 â€” <HOST-2-NAME>

- Total physical memory: 31.78 GB
- C: capacity: 952.93 GB
- C: free space: 889.97 GB

### Capacity Decision

- Both hosts have approximately 32 GB RAM.
- Host 2 currently has more available VM storage.
- VM placement must reserve enough memory for each Windows host operating system.
- Initial VM workload placement has been approved; deployment remains pending.

## Approved Initial VM Placement

### Host 1 â€” Network and Test Endpoints

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

### Host 2 â€” Core Server and Monitoring Services

- Windows Server / Active Directory
  - Planned memory: 4â€“6 GB
  - Role: Domain controller, DNS, users, groups, and Group Policy
- Wazuh server
  - Planned memory: 8 GB
  - Role: Endpoint monitoring, alerting, and security analytics
- Splunk server
  - Planned memory: 6â€“8 GB
  - Role: Log ingestion, searching, dashboards, and investigations

### Placement Decisions

- Atomic Red Team will run inside the Windows client and will not require a separate VM.
- Security Onion is deferred.
- Security Onion may be tested later only when other memory-heavy monitoring VMs are powered off.
- Both Windows host operating systems must retain enough RAM for stable operation.
- VM memory values are initial planning values and will be verified during deployment.
- No VMs were created during this design step.

## Host 2 Hyper-V Storage Design

- Host: `<HOST-2-NAME>`
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

- Host: `<HOST-2-NAME>`

### Physical Ethernet

- Adapter name: `Ethernet`
- Interface: Intel(R) Ethernet Connection (7) I219-LM
- Status: Up
- Link speed: 1 Gbps
- MAC address: `<HOST-2-ETHERNET-MAC>`
- Current role: Available for future lab networking; no longer the active management connection
- Previous management IPv4 address: `<HOST-2-PREVIOUS-MANAGEMENT-IP>`

### USB Wi-Fi

- Adapter name: `Wi-Fi 2`
- Interface: Realtek RTL8811AU Wireless LAN 802.11ac USB 2.0 Network Adapter
- Status: Disconnected
- MAC address: `<HOST-2-WIFI-MAC>`
- Current role: Host 2 management connection
- Current management IPv4 address: `<HOST-2-MANAGEMENT-IP>`

### Hyper-V Virtual Adapter

- Adapter name: `vEthernet (Default Switch)`
- Status: Up
- Link speed reported: 10 Gbps
- MAC address: `<HYPERV-DEFAULT-SWITCH-MAC>`
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
- Management IPv4 address: `<HOST-1-MANAGEMENT-IP>`
- Network profile: Private

### Host 2

- Management interface: `Wi-Fi 2`
- Management IPv4 address: `<HOST-2-MANAGEMENT-IP>`
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

## Managed Switch Port Assignment â€” Port 2

- Switch: TP-Link TL-SG108E
- Switch port: 2
- Connected device: Host 2 `<HOST-2-NAME>`
- Host interface: Intel(R) Ethernet Connection (7) I219-LM
- Physical link: Up
- Switch Port 2 LED: On
- Ethernet network profile: Unidentified network
- Automatic IPv4 address: `169.254.125.231`
- Default gateway: None
- DHCP server: None detected
- Current purpose: Isolated physical lab connection
- Host 2 management remains on Wi-Fi `<HOST-2-MANAGEMENT-IP>`
- No VLAN, static IP, firewall rule, route, or NAT rule has been configured for Port 2.






## Managed Switch WAN Assignment â€” Ports 1 and 3

- Port 1 purpose: Upstream connection to the home gateway
- Port 3 purpose: Host 1 dedicated OPNsense WAN connection
- VLAN: 10 WAN-Link
- Port 1 membership: Untagged
- Port 3 membership: Untagged
- Port 1 PVID: 10
- Port 3 PVID: 10
- Link speed: 1000 Mbps full duplex on both ports
- VLAN 1 membership: Ports 2 and 4â€“8
- Host 2 Port 2 PVID: 1
- Host 2 Ethernet verification:
  - No IPv4 address from the home gateway
  - No IPv4 or IPv6 default gateway
  - Only a link-local IPv6 address
- Result: Host 2 Port 2 is isolated from the OPNsense WAN path.

## Phase 3 Planned Inter-Host VioletOps LAN â€” 2026-07-17

Status: Implemented and verified across Host 1, Host 2, and OPNsense

### Design Decision

- Host 1's built-in Intel Ethernet adapter remains dedicated to VioletOps-WAN.
- OPNsense WAN and VioletOps LAN will remain physically separated.
- Host 1 now uses a second physical Ethernet interface:
  - Amazon Basics USB 3.0 Gigabit Ethernet Adapter
  - Controller: ASIX AX88179
  - Verified role: Dedicated VioletOps LAN uplink
- Host 2's built-in Ethernet adapter will become its dedicated VioletOps LAN uplink.
- Wi-Fi remains the management path for both Windows hosts.

### Planned Physical Path

- OPNsense LAN virtual adapter
- VioletOps-LAN Hyper-V switch on Host 1
- Host 1 USB Gigabit Ethernet adapter
- TP-Link TL-SG108E managed switch
- Host 2 built-in Ethernet adapter
- Host 2 VioletOps LAN external Hyper-V switch
- Host 2 core-server and monitoring VMs

### Planned Addressing

- OPNsense LAN gateway: <OPNSENSE-LAN-IP>/24
- Host 1 VioletOps LAN management vNIC: <HOST-1-LAB-IP>/24
- Host 2 VioletOps LAN management vNIC: <HOST-2-LAB-IP>/24
- DHCP scope: <VIOLETOPS-DHCP-START>â€“<VIOLETOPS-DHCP-END>
- Planned infrastructure VM addresses are documented in the IP Addressing Plan.

### Security Controls

- The existing OPNsense WAN path on switch VLAN 10 will not be modified.
- Host 1's WAN external switch will retain AllowManagementOS = False.
- The inter-host LAN will use separate switch ports from the WAN path.
- Host 1 USB Ethernet installation, external Hyper-V switch conversion, and <HOST-1-LAB-IP>/24 restoration are complete.
- Host 2 external Hyper-V switch creation and <HOST-2-LAB-IP>/24 configuration are complete.
- Firewall rules, NAT, DHCP, VLAN separation, routing, network bridges, and Internet Connection Sharing were reviewed and verified after inter-host connectivity testing.
- GitHub documentation remains unchanged pending the separate sanitization review.


### Host 1 Implementation Verification â€” 2026-07-18

- USB Ethernet adapter: ASIX AX88179
- Windows adapter name: VioletOps-LAN-USB
- MAC address: <HOST-1-LAB-ADAPTER-MAC>
- Physical switch port: TP-Link Port 4
- Switch membership: VLAN 1 untagged
- Port PVID: 1
- Link speed: 1 Gbps
- Hyper-V switch: VioletOps-LAN
- Hyper-V switch type: External
- Management operating system sharing: Enabled
- Host 1 LAN address: <HOST-1-LAB-IP>/24
- Host 1 LAN default gateway: None
- OPNsense LAN attachment: Verified
- Host 1 to OPNsense connectivity: Passed
- OPNsense WAN connectivity after change: Passed
- OPNsense DNS resolution after change: Passed
- Host 2 inter-host LAN implementation is complete and verified.


### Host 2 Implementation Verification â€” 2026-07-18

- Host: <HOST-2-NAME>
- Physical Ethernet adapter: Intel(R) Ethernet Connection (7) I219-LM
- Physical adapter MAC address: <HOST-2-ETHERNET-MAC>
- Physical switch port: TP-Link Port 2
- Switch membership: VLAN 1 untagged
- Port PVID: 1
- Link speed: 1 Gbps
- Hyper-V switch: VioletOps-LAN
- Hyper-V switch type: External
- Management operating system sharing: Enabled
- Host 2 LAN address: <HOST-2-LAB-IP>/24
- Host 2 LAN default gateway: None
- Host 2 IPv4 DNS servers: None
- Host 2 LAN network profile: Private
- Host 2 Wi-Fi management address: <HOST-2-MANAGEMENT-IP>/24
- Host 2 active default route: Wi-Fi 2 through <HOME-GATEWAY-IP>
- Host 2 to OPNsense connectivity: Passed
- Host 2 to Host 1 connectivity: Passed
- Host 1 to Host 2 connectivity: Passed
- Inter-host packet loss: 0 percent


### Host 1 Storage Preparation â€” 2026-07-19

- Created C:\HyperV.
- Created C:\HyperV\Virtual Machines.
- Created C:\HyperV\Virtual Hard Disks.
- The folders were verified to exist and were empty before use.
- Existing OPNsense storage remains unchanged on V:\HyperV-VMs\OPNsense-Gateway.
- Host 1 Hyper-V default paths have not yet been changed.
- No VM, virtual switch, IP address, MAC address, firewall rule, NAT rule, DHCP setting, or VLAN configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

### Host 1 Hyper-V Storage Assignment â€” 2026-07-19

- Host 1 default virtual machine path: `C:\HyperV\Virtual Machines`
- Host 1 default virtual hard disk path: `C:\HyperV\Virtual Hard Disks`
- Planned Windows 11 and Kali VMs will use the higher-capacity `C:` datastore.
- Existing OPNsense storage remains unchanged at `V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx`.
- No existing VM files were moved.
- No virtual switch, IP address, MAC address, firewall rule, NAT rule, DHCP setting, or VLAN configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

### Phase 3 Verified VM Capacity and Placement â€” 2026-07-19

#### Host 1

- CPU: 8 cores / 8 logical processors
- Memory: 31.79 GB installed
- Planned VM memory: 14 GB total
- Planned vCPU allocation: 6 total
- Future VM datastore: `C:\HyperV`
- OPNsense datastore: `V:\HyperV-VMs\OPNsense-Gateway`
- Windows 11: 6 GB RAM, 2 vCPU, 64 GB dynamic VHDX
- Kali Linux: 4 GB RAM, 2 vCPU, 40 GB dynamic VHDX
- OPNsense: 4 GB RAM, 2 vCPU, 25 GB dynamic VHDX
- Estimated free memory after all planned VMs start: approximately 8.77 GB
- Estimated C: free space after full Windows 11 and Kali VHDX growth: approximately 589.65 GB

#### Host 2

- CPU: 8 cores / 8 logical processors
- Memory: 31.78 GB installed
- Planned VM memory: 20 GB total
- Planned vCPU allocation: 8 total
- VM datastore: `C:\HyperV`
- Windows Server: 6 GB RAM, 2 vCPU, 80 GB dynamic VHDX
- Wazuh: 8 GB RAM, 4 vCPU, 120 GB dynamic VHDX
- Splunk: 6 GB RAM, 2 vCPU, 100 GB dynamic VHDX
- Estimated free memory after all planned VMs start: approximately 6.25 GB
- Estimated C: free space after full planned VHDX growth: approximately 591.45 GB
- Host 2 CPU and memory usage must be monitored before increasing any allocation.

- Security Onion remains deferred.
- No VM was created during this capacity review.
- No network, IP address, MAC address, firewall, NAT, DHCP, or VLAN configuration changed.
- GitHub was not updated or pushed pending sanitization review.

### Phase 3 DC01 Deployment - 2026-07-19

- VM name: `VioletOps-DC01`
- Hyper-V host: `<HOST-2-NAME>`
- Generation: 2
- vCPU: 2
- Startup memory: 6 GB static
- Checkpoints: Disabled
- VM path: `C:\HyperV\Virtual Machines`
- VHDX path: `C:\HyperV\Virtual Hard Disks\VioletOps-DC01.vhdx`
- VHDX type: Dynamic
- VHDX maximum size: 80 GB
- Virtual switch: `VioletOps-LAN`
- Virtual NIC MAC address: `<DC01-MAC>`
- Static IPv4 address: `<DC01-IP>/24`
- Default gateway: `<OPNSENSE-LAN-IP>`
- Active Directory forest: `violetops.internal`
- NetBIOS domain: `VIOLETOPS`
- Server role: Forest-root domain controller and DNS server
- AD DS and DNS services verified running
- `dcdiag` connectivity, advertising, services, and DNS tests passed
- Time zone: Central Standard Time
- Active UTC offset during daylight saving time: UTC-5
- External NTP peers: `time.cloudflare.com` and `time.google.com`
- Verified active time source: `time.google.com`
- Hyper-V Time Synchronization integration service disabled for DC01
- DC01 configured as a reliable Windows Time source for future domain members
- No OPNsense firewall rule, NAT rule, DHCP scope, VLAN, or physical-switch configuration was changed
- GitHub documentation was not updated or pushed pending sanitization review

### Phase 3 Windows 11 Workstation Deployment - 2026-07-20

- VM name: `VioletOps-WIN11`
- Computer name: `VIOLETOPS-WIN11`
- Hyper-V host: `<HOST-1-NAME>`
- Generation: 2
- vCPU: 2
- Startup memory: 6 GB static
- Checkpoints: Disabled
- VM configuration path: `C:\HyperV\Virtual Machines`
- VHDX path: `C:\HyperV\Virtual Hard Disks\VioletOps-WIN11.vhdx`
- VHDX type: Dynamic
- VHDX maximum size: 64 GB
- Virtual switch: `VioletOps-LAN`
- Virtual NIC MAC address: `<WIN11-MAC>`
- Static IPv4 address: `<WIN11-IP>/24`
- Default gateway: `<OPNSENSE-LAN-IP>`
- DNS server: `<DC01-IP>`
- Operating system: Windows 11 Pro 25H2
- Verified OS build: `10.0.26200`
- Domain membership: `violetops.internal`
- Verified interactive domain account: `VIOLETOPS\Administrator`
- Domain secure channel: Healthy
- Group Policy source: `VIOLETOPS-DC01.violetops.internal`
- Default Domain Policy applied to the computer
- Windows Time source: `VIOLETOPS-DC01.violetops.internal`
- Hyper-V Time Synchronization integration service disabled for this VM
- Secure Boot: Enabled
- Virtual TPM: Enabled
- Installation ISO detached after deployment
- Virtual hard disk configured as the first boot device
- Controlled restart completed successfully
- Gateway, domain controller, DNS resolution, domain discovery, HTTPS connectivity, and post-restart domain authentication verified
- No OPNsense firewall rule, NAT rule, DHCP scope, VLAN, physical-switch, or virtual-switch configuration was changed
- GitHub documentation was not updated or pushed pending sanitization review

## Post-Rewire Network Validation â€” 2026-07-20

- Host 1 VioletOps LAN: <HOST-1-LAB-IP>/24
- Host 2 VioletOps LAN: <HOST-2-LAB-IP>/24
- Inter-host connectivity verified in both directions with 0% packet loss.
- Managed-switch cabling remained:
  - Port 1: Xfinity upstream
  - Port 2: Host 2 built-in Ethernet
  - Port 3: Host 1 built-in Ethernet
  - Port 4: Host 1 USB Ethernet
- Host 2 firewall rule added:
  - Display name: VioletOps LAN - Allow ICMPv4 Echo
  - Direction: Inbound
  - Protocol: ICMPv4
  - ICMP type: Echo Request
  - Remote network: <VIOLETOPS-LAN>
  - Interface: vEthernet (VioletOps-LAN)
  - Profile: Public
  - Action: Allow
- No OPNsense, NAT, DHCP, VLAN, physical-switch, or virtual-switch configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

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

## Phase 3 Wazuh Architecture Update â€” 2026-07-21

- Host 2: <HOST-2-NAME>
- VM: VioletOps-WAZUH
- Role: Wazuh all-in-one security monitoring platform
- Network: VioletOps-LAN
- Static IPv4 address: <WAZUH-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- Dashboard: https://<WAZUH-IP>
- Monitored lab systems will connect to:
  - TCP 1514 for agent events
  - TCP 1515 for agent enrollment
  - TCP 443 for dashboard access
- Wazuh manager, indexer, dashboard, and Filebeat are installed on the same VM.
- Indexer cluster health verified as green.
- No OPNsense firewall, NAT, DHCP, VLAN, routing, physical-switch, or virtual-switch changes were required.
- GitHub documentation remains unchanged pending sanitization review.

## Phase 3 Splunk Architecture Update - 2026-07-21

- Host 2: <HOST-2-NAME>
- VM: VioletOps-SPLUNK
- Role: Splunk Enterprise log collection, indexing, and search platform
- Generation: 2
- vCPU: 2
- Memory: 6 GB static
- Dynamic Memory: Disabled
- Virtual disk: 100 GB dynamically expanding
- Virtual disk path: C:\HyperV\Virtual Hard Disks\VioletOps-SPLUNK.vhdx
- VM configuration path: C:\HyperV\Virtual Machines\VioletOps-SPLUNK\VioletOps-SPLUNK
- Virtual switch: VioletOps-LAN
- MAC address: <SPLUNK-MAC>
- Operating system: Ubuntu Server 22.04.5 LTS
- Kernel: 5.15.0-186-generic
- Hostname: violetops-splunk
- Network interface: eth0
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
- Splunk boot-start enabled under the dedicated splunk service account.
- Ubuntu UFW status: inactive.
- Access is currently controlled by the isolated VioletOps LAN boundary rather than guest-level UFW rules.
- Automatic checkpoints were removed and disabled.
- Ubuntu package baseline verified fully up to date.
- No OPNsense firewall, NAT, DHCP, VLAN, routing, physical-switch, or virtual-switch changes were required.
- GitHub documentation remains unchanged pending sanitization review.




## Phase 4 Identity, Policy, and Telemetry Architecture Update - 2026-07-23

- Active Directory domain: violetops.internal
- Domain controller: VioletOps-DC01 at <DC01-IP>
- Organizational unit structure:
  - VioletOps
  - Admins
  - Groups
  - Servers
  - Users
  - Workstations
- VioletOps-WIN11 is located in the Workstations OU.
- Standard account: soc.analyst
- Standard security group: GG-SOC-Analysts
- Privileged account: vo.admin
- Privileged security group: GG-VioletOps-Admins
- GG-VioletOps-Admins is nested in Domain Admins.
- Domain password minimum length: 14 characters.
- Account lockout threshold: 5 invalid attempts.
- Account lockout duration and reset window: 15 minutes.
- VioletOps Workstation Security Baseline GPO is linked to the Workstations OU.
- Workstation GPO enables:
  - PowerShell Script Block Logging
  - PowerShell Module Logging
  - Command-line inclusion in process creation events
  - Successful Process Creation auditing
- VioletOps-WIN11 forwards Windows security telemetry to Wazuh.
- Wazuh verified failed-logon detection for Event ID 4625 from VioletOps-WIN11.
- Wazuh verified account-lockout detection for Event ID 4740 from VioletOps-DC01.
- Host 1 and VioletOps-WIN11 synchronize time through VioletOps-DC01.
- No IP addresses, firewall rules, VLANs, routing, virtual switches, or VM placement changed during this Phase 4 update.

## Phase 5 Centralized Logging Architecture Update - 2026-07-25

### Windows Telemetry to Splunk

- Source endpoint: `VIOLETOPS-WIN11`
- Forwarder: Splunk Universal Forwarder 10.4.1
- Destination: `VioletOps-SPLUNK`
- Transport: TCP 9997
- Data path: `VIOLETOPS-WIN11 -> Splunk Universal Forwarder -> TCP 9997 -> VioletOps-SPLUNK`
- Collected sources:
  - Windows Security
  - Microsoft-Windows-PowerShell/Operational
  - Microsoft-Windows-Sysmon/Operational
- Effective index: `main`
- XML event rendering enabled.
- Verified Security, PowerShell, and Sysmon telemetry after controlled reboot.

### OPNsense Firewall Telemetry to Splunk

- Source device: `OPNsense-Gateway`
- Log application: `filter (filterlog)`
- Destination: `VioletOps-SPLUNK`
- Transport: UDP 5514
- Data path: `OPNsense-Gateway -> UDP 5514 -> VioletOps-SPLUNK`
- Splunk source: `udp:5514`
- Splunk sourcetype: `opnsense:filterlog`
- Verified firewall block events after controlled reboot.

### Change Summary

- Added one Splunk TCP listener for Windows forwarding.
- Added one Splunk UDP listener for OPNsense firewall logs.
- Added one OPNsense remote logging destination.
- No VM placement, hardware allocation, IP assignment, NAT, DHCP, VLAN, routing, or firewall filtering rule changes were made.
