# VioletOps IP Addressing Plan

Status: Complete
Last Updated: August 8, 2026

## Home Management Network

Network: `<HOME-MANAGEMENT-NETWORK>`

### Host 1

- Device: Original VioletOps Hyper-V host
- Connection: Wi-Fi
- IPv4 address: `<HOST-1-MANAGEMENT-IP>`
- Address role: Home-network management
- VioletOps static assignment: No

### Host 2

- Device name: `<HOST-2-NAME>`
- Current management connection: Wi-Fi 2
- Previous Ethernet management IPv4 address: `<HOST-2-PREVIOUS-MANAGEMENT-IP>`
- Current Wi-Fi management IPv4 address: `<HOST-2-MANAGEMENT-IP>`
- VioletOps static assignment: No
- Future VioletOps LAN address: Pending Phase 3 implementation

## VioletOps LAN

Network: `<VIOLETOPS-LAN>`

- OPNsense LAN gateway: `<OPNSENSE-LAN-IP>/24`
- Host 1 VioletOps LAN adapter: `<HOST-1-LAB-IP>/24`
- DHCP range: `<VIOLETOPS-DHCP-START>-<VIOLETOPS-DHCP-END>`
- Host 2 VioletOps LAN address: Not assigned
- Inter-host lab network: Not implemented

## Current Addressing Decision

- No new static IP addresses were assigned during Phase 2.5.
- Host 2 now uses Wi-Fi management at `<HOST-2-MANAGEMENT-IP>`; Ethernet `<HOST-2-PREVIOUS-MANAGEMENT-IP>` is no longer the active management path.
- No Host 2 VLAN, gateway, DNS, or VioletOps LAN address has been configured.
- OPNsense WAN is connected and receives addressing by DHCP from the upstream gateway.
## Host 2 Wi-Fi Management Address

- Host: `<HOST-2-NAME>`
- Interface: `Wi-Fi 2`
- SSID profile: `WiFi`
- IPv4 address: `<HOST-2-MANAGEMENT-IP>`
- Default gateway: `<HOME-GATEWAY-IP>`
- Network category: Private
- Purpose: Host 2 management connection
- Host 2 Hyper-V Default Switch address: `<HYPERV-DEFAULT-SWITCH-IP>/20`
  - This is an internal Hyper-V address, not a management address.




## OPNsense WAN Addressing - July 15, 2026

- WAN interface: hn0
- Configuration method: DHCP
- Upstream network: Private home-gateway network
- WAN received a valid IPv4 lease and default gateway.
- IPv6 addressing was also received from the upstream gateway.
- Exact dynamic WAN addresses are retained only in private operational evidence and are not required in the sanitized GitHub documentation.
- LAN gateway remains <OPNSENSE-LAN-IP>/24.
- DHCP scope remains <VIOLETOPS-DHCP-START>-<VIOLETOPS-DHCP-END>.

## Phase 3 Planned Static Address Reservations — 2026-07-17

These addresses are reserved in documentation only. They have not yet been configured.

- Host 2 VioletOps LAN interface:
  - Planned IPv4 address: <HOST-2-LAB-IP>/24
  - Gateway: None on the Windows host interface
  - Purpose: Hyper-V host access to the isolated VioletOps LAN

- Windows Server / Active Directory:
  - Planned IPv4 address: <DC01-IP>/24
  - Planned default gateway: <OPNSENSE-LAN-IP>
  - Planned DNS role: Primary VioletOps domain DNS server

- Wazuh server:
  - Planned IPv4 address: <WAZUH-IP>/24
  - Planned default gateway: <OPNSENSE-LAN-IP>
  - Planned DNS server: <DC01-IP>

- Splunk server:
  - Planned IPv4 address: <SPLUNK-IP>/24
  - Planned default gateway: <OPNSENSE-LAN-IP>
  - Planned DNS server: <DC01-IP>

- Windows 11 client:
  - Planned IPv4 address: <WIN11-IP>/24
  - Planned default gateway: <OPNSENSE-LAN-IP>
  - Planned DNS server: <DC01-IP>

- Kali Linux:
  - Planned IPv4 address: <KALI-IP>/24
  - Planned default gateway: <OPNSENSE-LAN-IP>
  - Planned DNS server: <DC01-IP>

### Addressing Controls

- OPNsense remains <OPNSENSE-LAN-IP>/24.
- Host 1 remains <HOST-1-LAB-IP>/24.
- OPNsense DHCP remains <VIOLETOPS-DHCP-START>–<VIOLETOPS-DHCP-END>.
- Planned static infrastructure addresses remain outside the DHCP scope.
- No address listed in this section is active until individually configured and verified.
- Firewall rules will be reviewed when each workload is deployed.
- GitHub documentation remains unchanged pending sanitization review.

## Phase 3 Active Static Address — Kali Linux — 2026-07-20

- Hostname: violetops-kali
- IPv4 address: <KALI-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- Interface: eth0
- MAC address: <KALI-MAC>
- Status: Configured, verified, and persistent after reboot
- Address remains outside the OPNsense DHCP scope of <VIOLETOPS-DHCP-START>–<VIOLETOPS-DHCP-END>.
- No DHCP, NAT, firewall, VLAN, or routing changes were required.

## Phase 3 Active Static Address — Wazuh — 2026-07-21

- Hostname: wazuh
- IPv4 address: <WAZUH-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- Interface: eth0
- MAC address: <WAZUH-MAC>
- Status: Configured, verified, and persistent after reboot
- Dashboard: https://<WAZUH-IP>
- Address remains outside the OPNsense DHCP scope of <VIOLETOPS-DHCP-START>–<VIOLETOPS-DHCP-END>.
- No DHCP, NAT, firewall, VLAN, or routing changes were required.

## Phase 3 Active Static Address - Splunk - 2026-07-21

- Hostname: violetops-splunk
- IPv4 address: <SPLUNK-IP>/24
- Default gateway: <OPNSENSE-LAN-IP>
- DNS server: <DC01-IP>
- DNS search domain: violetops.internal
- Interface: eth0
- MAC address: <SPLUNK-MAC>
- Status: Configured, verified, and persistent after reboot
- Splunk Web: http://<SPLUNK-IP>:8000
- Splunk management API: TCP 8089
- Address remains outside the OPNsense DHCP scope of <VIOLETOPS-DHCP-START>–<VIOLETOPS-DHCP-END>.
- Ubuntu UFW is inactive; access is currently controlled by the isolated VioletOps LAN boundary.
- No DHCP, NAT, firewall, VLAN, routing, physical-switch, or virtual-switch changes were required.

## Phase 10 Section 8 - Detection Engineering Addressing No-Change Record - 2026-08-08

- No IP address, subnet, gateway, DNS server, DHCP scope, route, NAT rule, VLAN, virtual switch, or physical switch assignment changed.
- Existing VioletOps source, target, and Splunk addressing remained unchanged.
- Section 8 changes were limited to Windows Firewall logging, Splunk Universal Forwarder collection, and Splunk detection engineering.
- Phase 10 is technically validated, documented, published, and fully complete.
