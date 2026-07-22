# VioletOps Build Log

## July 3, 2026 - Hyper-V Internal LAN Switch

### Configuration

- Created Hyper-V internal switch: `VioletOps-LAN`
- Created host virtual adapter: `vEthernet (VioletOps-LAN)`
- Assigned host management address: `<HOST-1-LAB-IP>/24`
- VioletOps LAN network: `<VIOLETOPS-LAN>`
- Default gateway on host LAN adapter: None
- DNS servers on host LAN adapter: None
- Physical network adapter binding: None
- OPNsense adapters connected: No

### Verification

- Hyper-V switch type verified as Internal
- Host virtual adapter verified as Up
- Static IPv4 address state verified as Preferred
- No default gateway verified
- No DNS servers verified
- Host Wi-Fi connectivity was not modified

### Documentation

- Updated `HyperV_Virtual_Switch_Design.md`

## July 3, 2026 - OPNsense LAN Attachment

### Configuration

- Connected `OPNsense-Gateway` adapter `LAN` to `VioletOps-LAN`
- OPNsense LAN MAC address: `<OPNSENSE-LAN-MAC>`
- OPNsense WAN virtual switch: None
- OPNsense power state during change: Off

### Verification

- Verified `LAN` shows switch assignment `VioletOps-LAN`
- Verified `WAN` has no switch assignment
- No WAN switch was created
- No physical adapter binding was changed

### Documentation

- Updated `OPNsense-Gateway.md`
- Updated `HyperV_Virtual_Switch_Design.md`

## July 3, 2026 - Hyper-V External WAN Switch

### Configuration

- Created Hyper-V external switch: `VioletOps-WAN`
- Bound physical adapter: `Intel(R) Ethernet Connection (7) I219-LM`
- Windows adapter name: `Ethernet`
- Allow management operating system: False
- Intended role: Dedicated OPNsense WAN uplink
- OPNsense WAN adapter connected: No

### Verification

- Switch type verified as External
- No host-side `vEthernet (VioletOps-WAN)` adapter exists
- Wi-Fi remains the host's only default-gateway interface
- IPv4 binding on physical Ethernet is disabled
- IPv6 binding on physical Ethernet is disabled
- Hyper-V Extensible Virtual Switch binding is enabled
- Physical Ethernet link was disconnected during configuration

### Documentation

- Updated `HyperV_Virtual_Switch_Design.md`

## July 3, 2026 - OPNsense WAN Attachment

### Configuration

- Connected `OPNsense-Gateway` adapter `WAN` to `VioletOps-WAN`
- OPNsense WAN MAC address: `<OPNSENSE-WAN-MAC>`
- Final adapter mapping:
  - `WAN` -> `VioletOps-WAN`
  - `LAN` -> `VioletOps-LAN`
- OPNsense power state during change: Off

### Verification

- Verified both adapter-to-switch assignments
- Verified OPNsense remained powered off
- Verified Windows host management remains on Wi-Fi
- No host-side WAN virtual adapter exists

### Documentation

- Updated `OPNsense-Gateway.md`
- Updated `HyperV_Virtual_Switch_Design.md`

## July 3, 2026 - Hyper-V Storage Path Review

### Verified Storage State

- Hyper-V default VM path: `C:\ProgramData\Microsoft\Windows\Hyper-V`
- Hyper-V default VHD path: `C:\ProgramData\Microsoft\Windows\Virtual Hard Disks`
- Existing OPNsense storage path: `V:\HyperV-VMs\OPNsense-Gateway`
- `C:` free space: Approximately 707 GB
- `V:` free space: Approximately 143 GB

### Decision

- Global Hyper-V storage paths will remain on `C:` for now.
- `V:` will not be used as the sole datastore for all planned VioletOps VMs.
- New VM storage locations will be selected individually.
- No partitions or Hyper-V host paths were changed.

### Disk Layout Difference

- Original plan: `C:` approximately 350 GB and `V:` approximately 600+ GB
- Current layout: `C:` approximately 780 GB and `V:` approximately 150 GB
- Current `V:` label: `HyperV-VMs`
- Current `V:` allocation unit size: 4 KB
- Original planned allocation unit size: 64 KB

### Documentation

- Created `Disk_Layout_Comparison.md`

## July 3, 2026 - Pre-Resumption Follow-Up Complete

### Completed Items

- Rebuilt and documented the VioletOps Hyper-V virtual switches
- Reconnected the OPNsense WAN and LAN adapters
- Reviewed the Hyper-V default VM and VHD storage paths
- Documented the difference between the planned and current disk layouts

### Final Decision

- Hyper-V global default storage paths remain on `C:`
- VM storage locations will be selected individually
- No disk partitions were changed
- OPNsense remains powered off pending firewall configuration

### Documentation Status

- `HyperV_Virtual_Switch_Design.md`: Complete
- `Disk_Layout_Comparison.md`: Complete
- `OPNsense-Gateway.md`: In Progress
- `VioletOps_Build_Log.md`: Updated

## July 3, 2026 - OPNsense Memory Increase

### Configuration

- Increased `OPNsense-Gateway` startup memory from 2 GB to 4 GB.
- Dynamic memory remains disabled.
- Physical WAN cable remained disconnected.

### Reason

- OPNsense 26.1 ZFS installation warned that at least 3 GB of RAM was required.
- 4 GB was selected as the new static baseline.

### Verification

- Hyper-V reported startup memory: `4294967296` bytes.
- Hyper-V reported dynamic memory: `False`.

### Documentation

- Updated `OPNsense-Gateway.md`
- Updated `VioletOps_Build_Log.md`

## July 11, 2026 - Phase 2.5 Host 2 Baseline

### Configuration

- Enabled Microsoft Hyper-V on Host 2.
- Set Windows Time service to Automatic and started the service.
- Configured time source: `time.windows.com,0x8`.
- Created local Host 2 baseline file:
  - `C:\VioletOps\Documentation\Host2_HyperV_Baseline.md`

### Verification

- Host 2 device name: `<HOST-2-NAME>`
- Hyper-V feature: Enabled
- `vmms`: Running / Automatic
- `vmcompute`: Running / Manual
- Existing virtual machines: 0
- Existing virtual switches:
  - `Default Switch` - Internal
- Physical disk: SK hynix PC801 HFS001TEJ9X101N
- Disk capacity: 1 TB
- Partition style: GPT
- Disk health: Healthy
- BitLocker: Off / Fully decrypted
- Windows Time synchronization: Verified
- NTP leap indicator: 0 - no warning
- Time zone: Central Time (US & Canada)

### Change Boundaries

- No Host 2 VMs were created.
- No custom virtual switches were created.
- No disk partitions were changed.
- Hyper-V default storage paths remain on `C:`.
- No Host 2 production role or VM placement was assigned.
- Host 2 remains temporarily connected directly to the router by Ethernet.

### Documentation

- Updated `Hardware.md`.
- Created `Host2_HyperV_Baseline.md` locally on Host 2.
- Updated `VioletOps_Build_Log.md`.

## July 11, 2026 - VM Inventory Created

### Configuration

- Created `C:\VioletOps\Documentation\VM Inventory\VioletOps_VM_Inventory.md`.

### Verification

- Documented `OPNsense-Gateway` on Host 1.
- Documented Host 2 as Hyper-V enabled with zero existing VMs.
- Documented that Host 2 has no custom virtual switches.
- Documented that no additional VM placement decisions have been made.

### Documentation

- Created `VioletOps_VM_Inventory.md`.

## July 11, 2026 - Dual-Host Baseline Architecture Created

### Configuration

- Created `C:\VioletOps\Documentation\Architecture\VioletOps_Dual_Host_Baseline.md`.

### Verification

- Documented Host 1 management, Hyper-V switches, and OPNsense placement.
- Documented Host 2 management address, Hyper-V readiness, and zero assigned VMs.
- Documented the current dual-host physical topology.
- Documented that no inter-host lab network, VLANs, or Host 2 static VioletOps addressing exist yet.
- Verified the Markdown topology code block is properly closed.

### Documentation

- Created `VioletOps_Dual_Host_Baseline.md`.

## July 11, 2026 - IP Addressing and Firewall Baseline Documented

### Configuration

- Created `C:\VioletOps\Documentation\IP Addressing Plan\VioletOps_IP_Addressing_Plan.md`.
- Created `C:\VioletOps\Documentation\Firewall Rules\VioletOps_Firewall_Rules.md`.

### Verification

- Documented Host 1 management address: `<HOST-1-MANAGEMENT-IP>`.
- Documented Host 2 temporary management address: `<HOST-2-PREVIOUS-MANAGEMENT-IP>`.
- Documented OPNsense LAN address: `<OPNSENSE-LAN-IP>/24`.
- Documented Host 1 VioletOps LAN address: `<HOST-1-LAB-IP>/24`.
- Documented DHCP range: `<VIOLETOPS-DHCP-START>-<VIOLETOPS-DHCP-END>`.
- Verified no new static IP, VLAN, NAT, or firewall-rule changes were made during Phase 2.5.
- Verified OPNsense WAN remains disconnected.

### Documentation

- Created `VioletOps_IP_Addressing_Plan.md`.
- Created `VioletOps_Firewall_Rules.md`.

## July 11, 2026 - Dual-Monitor and Peripheral Baseline

### Configuration

- Documented the current dual-monitor arrangement.
- Documented Microsoft PowerToys Mouse Without Borders as the temporary cross-host control method.

### Verification

- Left monitor connected to Host 1 by DisplayPort-to-DisplayPort.
- Right monitor connected to Host 2 by DisplayPort-to-DisplayPort.
- Each monitor has one available HDMI input and one DVI input.
- Each monitor has two USB downstream ports and one SuperSpeed USB-B upstream port.
- Each host has one unused DisplayPort output.
- Two DisplayPort-to-HDMI cables remain available.
- Cross-PC copy and paste works.
- Cross-host mouse control and clipboard sharing were verified through PowerToys Mouse Without Borders.
- No KVM switch is currently installed.

### Documentation

- Updated `Hardware.md`.

## July 11, 2026 - Monitor Models Verified

### Verification

- Monitor 1 verified as Dell P2419H.
- Monitor 1 serial number: `<MONITOR-1-SERIAL>`.
- Monitor 2 verified as Dell P2419H.
- Monitor 2 serial number: `<MONITOR-2-SERIAL>`.

### Documentation

- Updated `Hardware.md`.

## July 11, 2026 - Dual-Host Display Architecture Updated

### Verification

- Documented two Dell P2419H monitors.
- Documented Host 1 connected to the left monitor by DisplayPort.
- Documented Host 2 connected to the right monitor by DisplayPort.
- Documented available HDMI, DVI, DisplayPort, and USB connectivity.
- Documented two available DisplayPort-to-HDMI cables.
- Documented Microsoft PowerToys Mouse Without Borders as the temporary cross-host control method.
- Documented that seamless one-keyboard/one-mouse control and a KVM remain deferred.

### Documentation

- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 11, 2026 - Dual-Host Capacity Verified

### Verification

- Host 1 `<HOST-1-NAME>`:
  - RAM: 31.79 GB
  - C: 780.50 GB total / 698.53 GB free
  - V: 150.00 GB total / 138.18 GB free
- Host 2 `<HOST-2-NAME>`:
  - RAM: 31.78 GB
  - C: 952.93 GB total / 889.97 GB free
- Verified Host 2 currently has more available VM storage.
- No VM workload assignments were made.

### Documentation

- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 12, 2026 - Host 2 Hyper-V Storage Paths Updated

### Configuration Change

- Host: `<HOST-2-NAME>`
- Previous virtual machine path:
  - `C:\ProgramData\Microsoft\Windows\Hyper-V`
- Previous virtual hard disk path:
  - `C:\ProgramData\Microsoft\Windows\Virtual Hard Disks`
- New virtual machine path:
  - `C:\HyperV\Virtual Machines`
- New virtual hard disk path:
  - `C:\HyperV\Virtual Hard Disks`

### Verification

- `Get-VMHost` confirmed both new paths.
- Host 2 had zero VMs during the change.
- No VM migration was required.
- Updated `Host2_HyperV_Baseline.md`.

## July 12, 2026 - Host 2 Network Adapter Baseline Verified

### Host

- Computer: `<HOST-2-NAME>`

### Verified Adapters

- Intel Ethernet:
  - Adapter name: `Ethernet`
  - Interface: Intel(R) Ethernet Connection (7) I219-LM
  - Status: Up
  - Link speed: 1 Gbps
  - MAC address: `<HOST-2-ETHERNET-MAC>`
  - Current role: Host management
  - Current IPv4 address: `<HOST-2-PREVIOUS-MANAGEMENT-IP>`
- USB Wi-Fi:
  - Adapter name: `Wi-Fi 2`
  - Interface: Realtek RTL8811AU Wireless LAN 802.11ac USB 2.0 Network Adapter
  - Status: Disconnected
  - MAC address: `<HOST-2-WIFI-MAC>`
  - Current role: Unassigned
- Hyper-V virtual adapter:
  - Adapter name: `vEthernet (Default Switch)`
  - Status: Up
  - MAC address: `<HYPERV-DEFAULT-SWITCH-MAC>`

### Change Control

- No custom Host 2 Hyper-V switch was created.
- No IP address, VLAN, firewall rule, NAT rule, or route was changed.
- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 12, 2026 - Managed Switch Physical Baseline Verified

### Device

- Model: TP-Link TL-SG108E
- Power state: Unplugged
- Location: Stored on shelf
- Connected ports: None
- Current VioletOps role: Not deployed

### Change Control

- No switch port assignments exist.
- No VLAN, trunk, mirror, WAN, management, or inter-host connection was created.
- Active switch configuration has not yet been verified.
- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 12, 2026 - Managed Switch Identified

### Asset Details

- Model: TP-Link TL-SG108E
- Label text: `UN/6.6`
- Hardware version: Unverified
- MAC address: `<MANAGED-SWITCH-MAC>`
- Serial number: `<SWITCH-SERIAL>`

### Status

- Power state: Unplugged
- Deployment status: Not deployed
- No switch configuration or cabling change was made.
- Updated `Hardware.md`.

## July 12, 2026 - Managed Switch Power-On Test

### Test

- Device: TP-Link TL-SG108E
- Power adapter connected: Yes
- Ethernet cables connected: None
- Power LED: On
- Port LEDs: Off
- Unusual noise or behavior: None reported

### Result

- Basic power-on test passed.
- No network, VLAN, IP address, firewall, or cabling changes were made.

## July 12, 2026 - Host 2 Wi-Fi Management Path Verified

### Configuration

- Host 2 Wi-Fi profile: `WiFi`
- Interface: `Wi-Fi 2`
- IPv4 address: `<HOST-2-MANAGEMENT-IP>`
- Default gateway: `<HOME-GATEWAY-IP>`
- Network category: Private
- Host 1 Wi-Fi profile also changed to Private.

### Firewall Change

- Host 1 inbound ICMPv4 echo rule enabled.
- Rule scope restricted to Private profile only.
- Host 2 successfully pinged Host 1 at `<HOST-1-MANAGEMENT-IP>`.

### Addressing Decision

- Host 2 Ethernet address `<HOST-2-PREVIOUS-MANAGEMENT-IP>` is no longer the active management path.
- Host 2 Wi-Fi is now the management connection.
- Updated `VioletOps_IP_Addressing_Plan.md`.
- Updated `VioletOps_Firewall_Rules.md`.

## July 12, 2026 - Mouse Without Borders Restored

### Configuration

- Host 1 Wi-Fi profile: Private
- Host 2 Wi-Fi profile: Private
- Host 1 Mouse Without Borders inbound rule:
  - Program: `C:\Users\<HOST-1-USER>\AppData\Local\PowerToys\PowerToys.MouseWithoutBorders.exe`
  - Profile: Private
- Host 2 Mouse Without Borders inbound rule:
  - Program: `C:\Users\<HOST-2-USER>\AppData\Local\PowerToys.MouseWithoutBorders.exe`
  - Profile: Private
- Host 2 Mouse Without Borders helper inbound rule:
  - Program: `C:\Users\<HOST-2-USER>\AppData\Local\PowerToys\PowerToys.MouseWithoutBordersHelper.exe`
  - Profile: Private

### Verification

- Host 2 reached Host 1 at `<HOST-1-MANAGEMENT-IP>`.
- Mouse movement between monitors works.
- Cross-PC clipboard copy and paste works.
- PowerToys `Refresh connections` restored the active session.
- No Public-profile firewall access was allowed.

### Documentation

- Updated `VioletOps_Firewall_Rules.md`.

## July 12, 2026 - Host 2 Ethernet Released for Lab Use

### Verification

- Host: `<HOST-2-NAME>`
- Interface: `Ethernet`
- Adapter: Intel(R) Ethernet Connection (7) I219-LM
- Status: Disconnected
- Active management path: `Wi-Fi 2`
- Management IPv4 address: `<HOST-2-MANAGEMENT-IP>`

### Design Decision

- Host 2 Ethernet is reserved for future VioletOps lab networking.
- No switch cable, VLAN, IP address, route, NAT rule, or firewall rule was added during this step.

## July 12, 2026 - Managed Switch Port 2 Connected to Host 2

### Physical Connection

- Switch: TP-Link TL-SG108E
- Port: 2
- Connected device: Host 2 `<HOST-2-NAME>`
- Host interface: Intel(R) Ethernet Connection (7) I219-LM
- Port 2 LED: On
- Physical link: Up

### Network State

- Ethernet profile: Unidentified network
- Automatic IPv4 address: `169.254.125.231`
- Default gateway: None
- DHCP server: None detected
- Host 2 management remains on Wi-Fi `<HOST-2-MANAGEMENT-IP>`

### Change Control

- No static IP address was assigned.
- No VLAN, firewall rule, route, NAT rule, or additional switch port was configured.
- Updated `VioletOps_Dual_Host_Baseline.md`.


## July 12, 2026 - Phase 2.5 Closure

### Status

- Phase 2.5 - Dual-Host Hardware and Monitor Baseline: Complete
- Host 1 and Host 2 hardware baselines verified
- Host 2 Hyper-V and storage paths verified
- Host 2 management Wi-Fi verified
- Host 2 Ethernet connected to TP-Link TL-SG108E Port 2
- Cross-host mouse control and clipboard sharing verified
- Initial VM workload placement approved
- Architecture, VM inventory, hardware, IP addressing, firewall rules, and build log reviewed
- Documentation audit completed with no stale Phase 2.5 blockers

### Deferred Work

- Inter-host lab networking
- Remaining managed-switch port assignments
- VLAN and trunk configuration
- Host 2 VioletOps lab IP assignment
- Approved VM deployment
- OPNsense WAN validation
- Physical KVM deployment
- Managed-switch hardware version verification

### Next Phase

- Resume Phase 2 - OPNsense Firewall Configuration and Validation

## July 13, 2026 - Git and GitHub Portfolio Baseline

### Configuration

- Installed Git for Windows version 2.55.0.
- Installed GitHub CLI version 2.96.0.
- Configured Git author name as `BexPy`.
- Configured commit email as `BexPy@users.noreply.github.com`.
- Initialized local repository at `C:\VioletOps\GitHub`.
- Created private GitHub repository `BexPy/VioletOps`.
- Added GitHub remote named `origin`.
- Pushed the sanitized Phase 2.5 documentation to branch `main`.

### Security Controls

- Only documentation files were copied into the Git repository.
- VM files, ISOs, backups, exports, and operational directories were excluded.
- Credential and sensitive-data keyword scans were completed.
- Monitor serial numbers were redacted from the public copy.
- Personal iCloud email was removed from commit metadata.
- Repository remained private during review and upload.

### Verification

- Local branch `main` matches `origin/main`.
- Verified commit: `c809f82`.
- Git working tree verified clean.

## July 15, 2026 - OPNsense WAN Physical Connection and Validation

### Switch Configuration

- Backed up the TP-Link managed-switch configuration before changes.
- Corrected VLAN 10 WAN-Link.
- Assigned Ports 1 and 3 as untagged VLAN 10 members.
- Set Ports 1 and 3 to PVID 10.
- Removed Port 2 from VLAN 10 and restored its PVID to 1.
- Removed Ports 1 and 3 from VLAN 1.
- Verified Ports 1 and 3 negotiated at 1000 Mbps full duplex.
- Verified Host 2 Port 2 remained isolated from the upstream gateway.

### OPNsense Validation

- Connected Host 1 Ethernet to managed-switch Port 3.
- Verified OPNsense WAN link became active.
- Verified an upstream DHCP lease and gateway were received.
- Successfully pinged 1.1.1.1 from the WAN interface with 0 percent packet loss.
- Successfully resolved IPv4 and IPv6 DNS records for cloudflare.com.
- No custom firewall or NAT rules were changed.

### Security and Documentation

- Switch credentials were not recorded.
- The switch MAC address was excluded from the sanitized documentation.
- Dynamic WAN addressing will be generalized before GitHub publication.

## July 15, 2026 - OPNsense Firewall and NAT Validation

- LAN rules reviewed:
  - Default IPv4 rule permits LAN net to any.
  - Default IPv6 rule permits LAN net to any.
- WAN rules reviewed:
  - No custom inbound WAN rules are configured.
- Outbound NAT mode:
  - Automatic outbound NAT rule generation.
- Generated outbound NAT rules were present.
- LAN-to-WAN forwarding test:
  - Source: Host 1 VioletOps-LAN address.
  - Destination: 1.1.1.1.
  - Result: 4 replies, 0 percent packet loss.
- A temporary host route was created only for testing and removed afterward.
- No permanent route, firewall rule, or NAT change was made.

## July 15, 2026 - WAN Gateway Monitoring Test Reverted

- Temporarily enabled IPv4 gateway monitoring on WAN_DHCP.
- Monitor target tested: 1.1.1.1.
- Gateway status changed to red.
- WAN internet and DNS had already been independently verified as working.
- Reverted to the prior configuration:
  - Gateway monitoring disabled
  - Monitor IP blank
  - Far Gateway unchecked
- Gateway status returned to green.
- No permanent gateway-monitoring change remains.





## July 16, 2026 - Documentation Encoding Repair

- Created and verified a backup of all 11 Markdown documentation files.
- Identified 22 Unicode replacement characters across five files.
- Restored:
  - Em dashes in headings and architecture labels
  - En dashes in DHCP and memory ranges
- Repaired files:
  - Hardware.md
  - HyperV_Virtual_Switch_Design.md
  - VioletOps_Firewall_Rules.md
  - VioletOps_IP_Addressing_Plan.md
  - VioletOps_VM_Inventory.md
- Verified zero remaining U+FFFD replacement characters.
- Verified repaired content using explicit UTF-8 decoding.
- No network, firewall, VM, IP address, or OPNsense configuration changed.
## July 16, 2026 - OPNsense Configuration Backup

- Downloaded the validated OPNsense system configuration in XML format.
- Excluded RRD performance data.
- Stored the backup privately at:
  - C:\VioletOps\Backups\OPNsense\OPNsense_Config_2026-07-16.xml
- Verified file size: 42,561 bytes.
- Verified XML parsing completed successfully.
- Verified XML root element: opnsense.
- The configuration backup will not be copied to GitHub.
- No network architecture, VM resources, IP addresses, firewall rules, NAT rules, or interface settings were changed.

## 2026-07-16 - OPNsense Administrative Session Hardening

- Changed the OPNsense web administration session timeout from 240 minutes to 30 minutes.
- Verified the saved value under System > Settings > Administration.
- HTTPS remains enabled on TCP port 443.
- Secure Shell Server remains disabled.
- Anti-lockout protection remains enabled.

## 2026-07-16 - Phase 2 Final OPNsense Configuration Backup

- Created a post-upgrade OPNsense XML configuration backup.
- Backup filename: OPNsense-Phase2-Final-26.1.11-2026-07-16.xml
- Private storage location: C:\VioletOps\Backups\OPNsense\
- File size verified: 43,035 bytes.
- XML header and opnsense root element verified.
- Temporary Downloads copy removed.
- Backup is excluded from GitHub because it contains sensitive operational configuration.

## 2026-07-16 - OPNsense Upgrade Checkpoint Cleanup

- Removed the temporary Hyper-V checkpoint named Pre-OPNsense-26.1.11-Upgrade-2026-07-15.
- Verified the checkpoint no longer appears under OPNsense-Gateway.
- Verified OPNsense-Gateway remained running after checkpoint removal.
- Verified the OPNsense web interface remained accessible.
- The validated XML configuration backups remain the long-term recovery method.

## 2026-07-16 - Phase 2 Architecture Drift Correction

- Updated VioletOps_Dual_Host_Baseline.md to reflect the active OPNsense WAN path.
- Replaced the stale disconnected-WAN topology with the verified VLAN 10 path.
- Recorded OPNsense WAN DHCP address <OPNSENSE-WAN-DHCP-IP>.
- Recorded completion of WAN DHCP, outbound IPv4, DNS, automatic outbound NAT, and LAN-to-WAN forwarding validation.
- Removed stale statements that WAN validation was paused or remained future work.
- Verified no stale WAN-validation statements remain in the architecture file.

## 2026-07-16 - Phase 2 Firewall and VM Inventory Closure Updates

- Updated VioletOps_Firewall_Rules.md to OPNsense 26.1.11_10-amd64.
- Replaced the stale paused-state firewall summary with the verified Phase 2 completion state.
- Updated VioletOps_VM_Inventory.md to OPNsense 26.1.11_10-amd64.
- Updated the VM inventory current phase to Phase 2 OPNsense firewall configuration and validation completed.
- Corrected Markdown spacing before the Host 2 section.
- Updated the VM inventory status to Phase 2 Complete.
- Updated the VM inventory last-updated date to July 16, 2026.

## 2026-07-16 - Phase 2 Final Documentation Audit

- Verified the Phase 2 firewall rules, VM inventory, architecture, and OPNsense documentation match the current system state.
- Confirmed remaining references to OPNsense 26.1.6 are valid upgrade history.
- Confirmed remaining references to the disconnected WAN are valid historical Phase 2.5 records.
- Verified no stale active-state references remain for paused WAN validation or firewall/NAT review.

## 2026-07-16 - Phase 2 Roadmap Closure

- Updated VioletOps_Roadmap_and_Checklist.md.
- Marked Phase 2 Firewall as complete on July 16, 2026.
- Unblocked the roadmap file after Windows identified it as originating from an untrusted source.
- Verified the saved Phase 2 completion entry.
## 2026-07-17 - Phase 3 Legacy Hyper-V Disk Review

- Host reviewed: <HOST-1-NAME>
- Four legacy Wazuh virtual-disk files were found in:
  - C:\ProgramData\Microsoft\Windows\Virtual Hard Disks
- No registered virtual machine referenced these files.
- All four disks were verified as:
  - Unattached
  - RAW with no partition table
  - 4,194,304-byte dynamically allocated placeholder files
  - Configured with a 60 GB virtual capacity
- The AVHDX differencing disk referenced Wazuh-SIEM-Server.vhdx as its parent.
- All files were safely mounted read-only, inspected, dismounted, and verified detached.
- The files were preserved rather than deleted and moved to:
  - C:\VioletOps\Backups\Retired-VHDX\2026-07-17-Wazuh-Abandoned
- The original Hyper-V virtual hard disk folder was verified empty after the move.
- No active VioletOps virtual machine or OPNsense disk was modified.
- GitHub documentation was not pushed because the internal documentation still requires a separate sanitization review.

## 2026-07-17 - Phase 3 Host 1 Hyper-V Storage Standardization

- Host: <HOST-1-NAME>
- Previous default virtual machine path:
  - C:\ProgramData\Microsoft\Windows\Hyper-V
- Previous default virtual hard disk path:
  - C:\ProgramData\Microsoft\Windows\Virtual Hard Disks
- New default virtual machine path:
  - V:\HyperV-VMs\Virtual Machines
- New default virtual hard disk path:
  - V:\HyperV-VMs\Virtual Hard Disks
- Both new directories were created and verified.
- This change applies to future virtual machines and virtual disks.
- The existing OPNsense-Gateway VM was not moved or modified.
- OPNsense-Gateway remained running.
- Verified OPNsense configuration path:
  - V:\HyperV-VMs\OPNsense-Gateway\OPNsense-Gateway
- Verified OPNsense virtual disk:
  - V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx
- No IP addresses, firewall rules, or network switch configurations were changed.
- GitHub documentation was not pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 Host 2 Placement Record Correction

- File reviewed:
  - C:\VioletOps\Documentation\Hardware.md
- A July 11, 2026 change-record entry incorrectly stated that final Host 2 workload placement was approved.
- The detailed Host 2 baseline correctly stated that:
  - Host 2 was virtualization-ready.
  - Final VM workload placement had not yet been assigned.
- The inaccurate change-record sentence was corrected to state:
  - Final Host 2 workload placement remains pending Phase 3 architecture approval.
- No VM, storage, network, IP address, firewall rule, or Hyper-V configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 VM Placement Inventory Reconciliation

- Reviewed the approved workload placement in:
  - C:\VioletOps\Documentation\Architecture\VioletOps_Dual_Host_Baseline.md
- Confirmed the approved initial placement:
  - Host 1: OPNsense-Gateway, Windows 11 client, and Kali Linux
  - Host 2: Windows Server / Active Directory, Wazuh, and Splunk
- Confirmed:
  - Atomic Red Team will run inside the Windows 11 client.
  - Security Onion remains deferred.
- Updated:
  - C:\VioletOps\Documentation\VioletOps_VM_Inventory.md
- Corrected both host entries from placement pending to placement approved.
- Added the detailed approved Phase 3 VM placement and resource targets.
- A PowerShell write-order issue temporarily removed the detailed section.
- The detailed section was restored and verified beginning at line 55.
- No VM, IP address, VLAN, route, firewall rule, NAT rule, or virtual-switch configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 Inter-Host Networking Hardware Dependency

- Host 1 has one built-in physical Ethernet adapter.
- The built-in Ethernet adapter remains dedicated to the isolated OPNsense WAN path.
- Combining the OPNsense WAN and VioletOps LAN on the same physical adapter was rejected.
- A second network adapter is required for a physically separated VioletOps LAN connection.
- Ordered adapter:
  - Amazon Basics USB 3.0 to 10/100/1000 Gigabit Ethernet Adapter
  - Controller: ASIX AX88179
  - Intended host: <HOST-1-NAME>
  - Intended role: Dedicated Host 1 VioletOps LAN uplink
- Phase 3 architecture and documentation work may continue while the adapter is in transit.
- Inter-host network implementation, Host 2 OPNsense-LAN validation, and production VM deployment remain blocked until the adapter is installed and verified.
- No network, VLAN, IP address, firewall rule, route, NAT rule, or Hyper-V switch configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 Host 2 IP Plan Reconciliation

- Updated:
  - C:\VioletOps\Documentation\IP Addressing Plan\VioletOps_IP_Addressing_Plan.md
- Corrected Host 2 management connection to:
  - Wi-Fi 2
- Corrected current Host 2 management address to:
  - <HOST-2-MANAGEMENT-IP>/24
- Relabeled <HOST-2-PREVIOUS-MANAGEMENT-IP> as the previous Ethernet management address.
- Corrected the Host 2 Hyper-V Default Switch address from:
  - <LEGACY-INTERNAL-IP>
- To the currently verified address:
  - <HYPERV-DEFAULT-SWITCH-IP>/20
- Host 2 VioletOps LAN addressing remains pending Phase 3 implementation.
- No IP address, route, VLAN, firewall rule, NAT rule, or virtual-switch configuration was changed on either host.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 Static IP Reservation Plan

- Updated:
  - C:\VioletOps\Documentation\IP Addressing Plan\VioletOps_IP_Addressing_Plan.md
- Reserved the following planned VioletOps LAN addresses:
  - Host 2 LAN interface: <HOST-2-LAB-IP>/24
  - Windows Server / Active Directory: <DC01-IP>/24
  - Wazuh server: <WAZUH-IP>/24
  - Splunk server: <SPLUNK-IP>/24
  - Windows 11 client: <WIN11-IP>/24
  - Kali Linux: <KALI-IP>/24
- Existing addressing remains:
  - OPNsense LAN: <OPNSENSE-LAN-IP>/24
  - Host 1 VioletOps LAN: <HOST-1-LAB-IP>/24
  - DHCP scope: <VIOLETOPS-DHCP-START>-<VIOLETOPS-DHCP-END>
- All planned static addresses are outside the DHCP scope.
- The reservations are documentation-only and have not been configured.
- No IP address, gateway, DNS setting, VLAN, route, firewall rule, NAT rule, or virtual-switch configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - Phase 3 Planned Inter-Host LAN Architecture

- Updated:
  - C:\VioletOps\Documentation\Architecture\VioletOps_Dual_Host_Baseline.md
- Documented the planned physically separated inter-host VioletOps LAN.
- Host 1 built-in Intel Ethernet remains dedicated to the OPNsense WAN path.
- Host 1 planned LAN uplink:
  - Amazon Basics USB 3.0 Gigabit Ethernet Adapter
  - ASIX AX88179 controller
- Host 2 built-in Ethernet will become its dedicated VioletOps LAN uplink.
- Wi-Fi remains the Windows management path for both hosts.
- Planned Host 2 VioletOps LAN address:
  - <HOST-2-LAB-IP>/24
- Existing WAN VLAN 10 and OPNsense isolation controls will remain unchanged.
- The design is documented as planned and not yet implemented.
- No cable, VLAN, IP address, route, firewall rule, NAT rule, or Hyper-V switch configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.

## 2026-07-17 - VM Inventory Reconciliation Completed

- Reconciled duplicate VM inventory files.
- Verified backups created under:
  - C:\VioletOps\Backups\VM-Inventory-Reconciliation-2026-07-17
- Promoted the reconciled inventory to:
  - C:\VioletOps\Documentation\VM Inventory\VioletOps_VM_Inventory.md
- Verified promoted file hash:
  - 5CFDD560968E91455ADA02B678BB1BD395280EE6F6725F7F1E4754B61FDC5C1E
- Archived the duplicate root inventory as:
  - C:\VioletOps\Backups\VM-Inventory-Reconciliation-2026-07-17\Retired-Root-VioletOps_VM_Inventory.md
- Confirmed only one active internal VM inventory remains.
- Restored all planned VM names and retained the complete Phase 2 validation record.
- Added the verified Phase 3 host-capacity baseline.
- Repaired known em-dash and en-dash encoding damage in the reconciled inventory.
- No VM, IP address, VLAN, route, firewall rule, NAT rule, or Hyper-V switch configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.


## 2026-07-18 - Host 1 USB Ethernet Adapter Verified

- Installed and detected the ASIX AX88179 USB 3.0 Gigabit Ethernet adapter.
- Renamed the Windows interface to VioletOps-LAN-USB.
- Recorded MAC address <HOST-1-LAB-ADAPTER-MAC>.
- Connected the adapter to TP-Link switch Port 4 using a CAT 5e cable.
- Verified connected media state and 1 Gbps link negotiation.
- Confirmed no IPv4 default gateway is assigned.
- No VLAN, IP address, route, firewall rule, NAT rule, or Hyper-V switch configuration was changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## 2026-07-18 - Host 1 VioletOps LAN External Switch Conversion Completed

- Replaced the Host 1 internal Hyper-V switch named VioletOps-LAN with an external Hyper-V switch using:
  - ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter
- Physical adapter name:
  - VioletOps-LAN-USB
- Physical connection:
  - Host 1 USB Ethernet adapter to TP-Link TL-SG108E Port 4
- Verified physical link speed:
  - 1 Gbps
- Hyper-V management operating system sharing:
  - Enabled
- Reattached the OPNsense-Gateway LAN virtual adapter to:
  - VioletOps-LAN
- Restored Host 1 VioletOps LAN address:
  - <HOST-1-LAB-IP>/24
- Confirmed Host 1 VioletOps LAN default gateway:
  - None
- Confirmed Host 1 IPv4 DNS servers:
  - None
- Verified Host 1 to OPNsense LAN connectivity:
  - <OPNSENSE-LAN-IP>
  - Four successful ICMP replies
- Verified OPNsense WAN connectivity:
  - 1.1.1.1 ping completed with 0 percent packet loss
- Verified OPNsense DNS resolution:
  - cloudflare.com A, AAAA, MX, and TXT records resolved successfully
- Preserved the OPNsense WAN path:
  - VLAN 10
  - TP-Link Ports 1 and 3
  - Host 1 built-in Intel Ethernet adapter
- TP-Link Port 4 remains an untagged VLAN 1 member with PVID 1.
- No firewall rule, NAT rule, WAN IP address, DHCP range, or DNS service configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.


## 2026-07-18 - Host 2 VioletOps LAN External Switch Completed

- Host: <HOST-2-NAME>
- Physical Ethernet adapter:
  - Intel(R) Ethernet Connection (7) I219-LM
- Physical adapter MAC address:
  - <HOST-2-ETHERNET-MAC>
- Verified physical link speed:
  - 1 Gbps
- Physical switch connection:
  - TP-Link TL-SG108E Port 2
- Switch membership:
  - VLAN 1 untagged
- Port PVID:
  - 1
- Created Hyper-V switch:
  - VioletOps-LAN
- Hyper-V switch type:
  - External
- Management operating system sharing:
  - Enabled
- Host 2 management vNIC:
  - vEthernet (VioletOps-LAN)
- Static VioletOps LAN address:
  - <HOST-2-LAB-IP>/24
- VioletOps LAN default gateway:
  - None
- VioletOps LAN IPv4 DNS servers:
  - None
- VioletOps LAN network profile:
  - Private
- Host 2 Wi-Fi management address:
  - <HOST-2-MANAGEMENT-IP>/24
- Active IPv4 default route:
  - Wi-Fi 2 through <HOME-GATEWAY-IP>
- Verified Host 2 to OPNsense connectivity:
  - <OPNSENSE-LAN-IP>
  - Four successful ICMP replies
- Verified Host 2 to Host 1 connectivity:
  - <HOST-1-LAB-IP>
  - Four successful ICMP replies with 0 percent packet loss
- Verified Host 1 to Host 2 connectivity:
  - <HOST-2-LAB-IP>
  - Four successful ICMP replies with 0 percent packet loss
- No OPNsense firewall rule, NAT rule, DHCP scope, WAN VLAN, or WAN adapter configuration was changed.
- GitHub documentation was not updated or pushed pending the separate sanitization review.



## Phase 3 Security Boundary Verification - 2026-07-18

- Host 1 VioletOps LAN address: <HOST-1-LAB-IP>/24
- Host 1 VioletOps LAN default gateway: None
- Host 1 active IPv4 default route: Wi-Fi through <HOME-GATEWAY-IP>
- Host 1 network bridge: None
- Host 1 Internet Connection Sharing: Disabled on all adapters
- Host 2 network bridge: None
- Host 2 Internet Connection Sharing: Disabled on all adapters
- VioletOps-WAN physical adapter: Intel(R) Ethernet Connection (7) I219-LM
- VioletOps-WAN AllowManagementOS: False
- VioletOps-LAN physical adapter: ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter
- VioletOps-LAN AllowManagementOS: True
- OPNsense WAN virtual adapter attached to: VioletOps-WAN
- OPNsense LAN virtual adapter attached to: VioletOps-LAN
- TP-Link VLAN 10 ports: Ports 1 and 3, untagged, PVID 10
- TP-Link VLAN 1 ports: Ports 2 and 4-8, untagged, PVID 1
- OPNsense DHCP service: Dnsmasq DNS & DHCP
- OPNsense LAN DHCP range: <VIOLETOPS-DHCP-START>-<VIOLETOPS-DHCP-END>
- OPNsense outbound NAT mode: Automatic outbound NAT rule generation
- OPNsense LAN IPv4 rule: Default allow LAN to any rule
- OPNsense LAN IPv6 rule: Default allow LAN IPv6 to any rule
- Result: No Windows bridge or Internet Connection Sharing path exists between the home network and VioletOps.
- Result: OPNsense remains the routed security boundary for VioletOps traffic.
- GitHub documentation was not pushed pending the separate sanitization review.

## Phase 3 Host 1 Storage Preparation - 2026-07-19

- Verified that C:\HyperV did not previously exist.
- Created:
  - C:\HyperV
  - C:\HyperV\Virtual Machines
  - C:\HyperV\Virtual Hard Disks
- Verified all three folders exist.
- This prepares a higher-capacity datastore for the planned Windows 11 and Kali VMs.
- Existing OPNsense storage remains unchanged on V:.
- Hyper-V default paths were not changed during this step.
- No networking, firewall, NAT, DHCP, VLAN, IP address, or MAC address configuration changed.
- Documentation backups were created at:
  - C:\VioletOps\Backups\Documentation\Phase3-Host1-Storage-20260719-000056
- GitHub was not updated or pushed pending sanitization review.


## Phase 3 Host 1 Hyper-V Default Path Change - 2026-07-19

- Changed the Host 1 Hyper-V default virtual machine path from `V:\HyperV-VMs\Virtual Machines` to `C:\HyperV\Virtual Machines`.
- Changed the Host 1 Hyper-V default virtual hard disk path from `V:\HyperV-VMs\Virtual Hard Disks` to `C:\HyperV\Virtual Hard Disks`.
- Verified both new default paths through `Get-VMHost`.
- Verified that the OPNsense virtual disk remains at `V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx`.
- Existing OPNsense files were not moved or modified.
- No networking, firewall, NAT, DHCP, VLAN, IP address, or MAC address configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-Host1-DefaultPaths-20260719-000343
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 7 - Resource Capacity and VM Placement Approval - 2026-07-19

- Rechecked CPU, memory, storage, Hyper-V paths, and existing VMs on both hosts.
- Verified Host 1 future VM storage under `C:\HyperV` and confirmed OPNsense remains on `V:`.
- Verified Host 2 Hyper-V storage under `C:\HyperV`.
- Approved the initial RAM, vCPU, disk, host placement, and planned IP allocation for five future VMs.
- Host 1 retains an estimated 8.77 GB memory margin with all planned workloads running.
- Host 2 retains an estimated 6.25 GB memory margin with all planned workloads running.
- Host 1 retains approximately 589.65 GB after full planned future VHDX growth.
- Host 2 retains approximately 591.45 GB after full planned VHDX growth.
- Host 2 resource usage must be monitored before increasing any VM allocation.
- Security Onion remains deferred.
- Section 7 capacity review and placement approval completed.
- No VM or network configuration was created or changed during final approval.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-Capacity-Approval-20260719-000727
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 8 - Windows Server ISO Acquisition - 2026-07-19

- Downloaded the Windows Server 2025 Evaluation x64 English ISO from Microsoft.
- Stored the ISO on Host 2 under `C:\VioletOps\ISO`.
- Verified final file size as 7.592 GB.
- Verified SHA-256 as `7B052573BA7894C9924E3E87BA732CCD354D18CB75A883EFA9B900EA125BFD51`.
- Hash comparison passed after the file was placed in its final folder.
- The ISO was not mounted and no VM was created.
- No IP address, MAC address, firewall rule, NAT rule, DHCP setting, VLAN, or virtual switch configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-WindowsServerISO-20260719-004120
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 8 - Windows 11 ISO Acquisition - 2026-07-19

- Downloaded the Windows 11 25H2 English x64 ISO from Microsoft.
- Stored the ISO on Host 1 under `C:\VioletOps\ISO`.
- Verified final file size as 7.890 GB.
- Verified SHA-256 as `768984706B909479417B2368438909440F2967FF05C6A9195ED2667254E465E3`.
- Hash comparison passed after the ISO was moved to its final folder.
- The ISO was not mounted and no VM was created.
- No IP address, MAC address, firewall rule, NAT rule, DHCP setting, VLAN, or virtual switch configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-Windows11ISO-20260719-013423
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 8 - Kali Linux ISO Acquisition - 2026-07-19

- Downloaded the Kali Linux 2026.2 amd64 Installer ISO from the official Kali website.
- Verified the ISO against Kali Linux official `SHA256SUMS`.
- Official checksum comparison passed.
- Stored the ISO on Host 1 under `C:\VioletOps\ISO`.
- Verified final file size as 4.473 GB.
- Verified SHA-256 as `6DBEFACC95E3B556C19C48E8BAE39B8B505E2D3A1ABA0BFB7AB62B036C3D2BA3`.
- Hash remained unchanged after the ISO was moved to its final folder.
- The ISO was not mounted and no VM was created.
- No IP address, MAC address, firewall rule, NAT rule, DHCP setting, VLAN, or virtual switch configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-KaliISO-20260719-014511
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 8 - Ubuntu Server ISO Acquisition - 2026-07-19

- Downloaded Ubuntu Server 22.04.5 LTS amd64 ISO to Host 2.
- Stored the ISO under `C:\VioletOps\ISO`.
- Verified final file size as 1.990 GB.
- Verified SHA-256 as `9BC6028870AEF3F74F4E16B900008179E78B130E6B0B9A140635434A46AA98B0`.
- Official Ubuntu checksum comparison passed.
- The ISO is approved for the planned Wazuh and Splunk VMs.
- The ISO was not mounted and no VM was created.
- No IP address, MAC address, firewall rule, NAT rule, DHCP setting, VLAN, or virtual switch configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-UbuntuISO-20260719-175832
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 Section 8 - Installation Media Review Complete - 2026-07-19

- Completed final ISO inventories on both Hyper-V hosts.
- Verified Windows Server 2025, Windows 11 25H2, Kali Linux 2026.2, Ubuntu Server 22.04.5, and OPNsense installation media.
- Verified Kali and Ubuntu against their publishers' official SHA-256 checksum files.
- Verified final file hashes after storage placement.
- Removed one incomplete Ubuntu download from Host 1 and confirmed the valid reference copy remained unchanged.
- Confirmed Host 2 contains Windows Server and Ubuntu media required for its planned workloads.
- Confirmed Host 1 contains Windows 11 and Kali media required for its planned workloads.
- OPNsense duplicate ISO copies were identified but not deleted.
- Section 8 installation-media review completed.
- No VM was created and no ISO was mounted.
- No IP address, MAC address, firewall rule, NAT rule, DHCP setting, VLAN, or virtual switch configuration changed.
- Documentation backup folder: C:\VioletOps\Backups\Documentation\Phase3-Section8-Closure-20260719-181747
- GitHub was not updated or pushed pending sanitization review.

## Phase 3 - VioletOps-DC01 Deployment and Validation - 2026-07-19

- Created `VioletOps-DC01` on Hyper-V Host 2 (`<HOST-2-NAME>`).
- Configured Generation 2, 2 vCPU, 6 GB static RAM, and disabled checkpoints.
- Created an 80 GB dynamic VHDX at `C:\HyperV\Virtual Hard Disks\VioletOps-DC01.vhdx`.
- Connected the VM to the `VioletOps-LAN` virtual switch.
- Verified virtual NIC MAC address `<DC01-MAC>` and adapter status OK.
- Installed Windows Server 2025 Standard Evaluation Desktop Experience.
- Renamed the server to `VIOLETOPS-DC01`.
- Assigned static IPv4 address `<DC01-IP>/24`.
- Assigned default gateway `<OPNSENSE-LAN-IP>`.
- Promoted the server as the forest-root domain controller for `violetops.internal`.
- Verified NetBIOS domain `VIOLETOPS`.
- Installed and verified Active Directory Domain Services and DNS Server roles.
- Verified DNS and NTDS services are running and configured for automatic startup.
- Verified `dcdiag` connectivity, advertising, services, and DNS tests passed.
- Corrected the server time zone to Central Standard Time.
- Disabled Hyper-V Time Synchronization for DC01.
- Configured external NTP peers `time.cloudflare.com` and `time.google.com`.
- Configured DC01 as a reliable Windows Time source for future domain members.
- Verified active time source `time.google.com`, Stratum 2, and successful synchronization.
- Verified active daylight-saving offset UTC-5.
- No password or other secret was documented.
- No OPNsense firewall rule, NAT rule, DHCP scope, VLAN, or physical-switch configuration was changed.
- Documentation backup folder: `C:\VioletOps\Backups\Documentation\Phase3-DC01-20260719-222000`
- Updated the network architecture, VM inventory, and Build Log.
- GitHub documentation was not updated or pushed pending sanitization review.

### DC01 DNS Client Verification - 2026-07-19

- Verified `VIOLETOPS-DC01` uses `127.0.0.1` as its IPv4 DNS server.
- This confirms the domain controller is using its locally installed DNS service.
- No firewall, NAT, DHCP, VLAN, IP address, or virtual-switch configuration changed.
- GitHub documentation was not updated or pushed pending sanitization review.

## Phase 3 - VioletOps-WIN11 Deployment and Validation - 2026-07-20

- Created `VioletOps-WIN11` on Hyper-V Host 1 (`<HOST-1-NAME>`).
- Configured Generation 2, 2 vCPU, 6 GB static RAM, and disabled Dynamic Memory.
- Disabled checkpoints.
- Created a 64 GB dynamic VHDX at `C:\HyperV\Virtual Hard Disks\VioletOps-WIN11.vhdx`.
- Connected the VM to the `VioletOps-LAN` virtual switch.
- Enabled Secure Boot using the Microsoft Windows template.
- Enabled the virtual TPM after creating a local key protector.
- Installed Windows 11 Pro 25H2.
- Renamed the computer to `VIOLETOPS-WIN11`.
- Assigned static IPv4 address `<WIN11-IP>/24`.
- Assigned default gateway `<OPNSENSE-LAN-IP>`.
- Assigned DNS server `<DC01-IP>`.
- Verified gateway connectivity to `<OPNSENSE-LAN-IP>`.
- Verified domain-controller connectivity to `<DC01-IP>`.
- Verified DNS resolution and discovery for `violetops.internal`.
- Joined the workstation to the `violetops.internal` domain.
- Verified interactive sign-in as `VIOLETOPS\Administrator`.
- Verified the domain secure channel remained healthy after restart.
- Verified the Default Domain Policy applied from `VIOLETOPS-DC01.violetops.internal`.
- Disabled Hyper-V Time Synchronization for this VM.
- Verified Windows Time source `VIOLETOPS-DC01.violetops.internal`.
- Verified HTTPS connectivity to Microsoft over TCP 443.
- Verified virtual NIC MAC address `<WIN11-MAC>`.
- Detached the Windows 11 installation ISO after deployment.
- Set the virtual hard disk as the first boot device.
- Completed a controlled restart and verified normal boot, domain membership, domain authentication, time synchronization, and secure-channel health.
- No password or other secret was documented.
- No OPNsense firewall rule, NAT rule, DHCP scope, VLAN, physical-switch, or virtual-switch configuration was changed.
- Pre-update documentation backup created under `C:\VioletOps\Backups\Documentation\Phase3-WIN11-PreUpdate-*`.
- Updated the network architecture, VM inventory, and Build Log.
- GitHub documentation was not updated or pushed pending sanitization review.

- Final documentation backup folder: `C:\VioletOps\Backups\Documentation\Phase3-WIN11-Final-20260720-021129`


## Post-Rewire Network Validation - 2026-07-20

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

## Post-Rewire VM Recovery Validation - 2026-07-20

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

- Final post-rewire VM recovery backup: `C:\VioletOps\Backups\Documentation\Post-Rewire-VM-Recovery-Final-20260720-211056`

## Phase 3 Kali Linux Deployment - 2026-07-20

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

## Phase 3 - Wazuh All-in-One Deployment - 2026-07-21

- Deployed `VioletOps-WAZUH` on Host 2 (`<HOST-2-NAME>`) as a Generation 2 Hyper-V VM.
- Assigned 4 vCPU, 8 GB static memory, and a 120 GB dynamic VHDX.
- Installed Ubuntu Server 22.04.5 LTS.
- Configured static network settings:
  - IP: <WAZUH-IP>/24
  - Gateway: <OPNSENSE-LAN-IP>
  - DNS: <DC01-IP>
  - Search domain: violetops.internal
- Installed Wazuh 4.14.6-1 all-in-one components:
  - wazuh-manager
  - wazuh-indexer
  - wazuh-dashboard
  - filebeat
- Verified dashboard access from WIN11 at `https://<WAZUH-IP>`.
- Verified TCP 443, 1514, 1515, and 55000 were listening.
- Verified Filebeat connected to the indexer over TLS.
- Verified Wazuh indices were created and receiving alerts.
- Verified indexer cluster health was green with no unassigned shards.
- Verified no failed systemd services.
- No OPNsense firewall, NAT, DHCP, VLAN, or routing changes were required.
- GitHub documentation remains unchanged pending sanitization review.


### Wazuh Endpoint Integration Verification — 2026-07-21

- Enrolled VIOLETOPS-DC01 as Wazuh agent 001.
- Enrolled VIOLETOPS-WIN11 as Wazuh agent 002.
- Both agents verified Active in Wazuh manager.
- VIOLETOPS-WIN11 event ingestion verified with 489 Threat Hunting results in the last hour.
- VIOLETOPS-DC01 event ingestion verified with 634 Threat Hunting results in the last hour.
- Windows 11 time synchronization verified against VIOLETOPS-DC01 at <DC01-IP>.
- No firewall, NAT, DHCP, VLAN, routing, or virtual-switch changes were required.

## Phase 3 - Splunk Enterprise Deployment - 2026-07-21

- Deployed `VioletOps-SPLUNK` on Host 2 (`<HOST-2-NAME>`) as a Generation 2 Hyper-V VM.
- Assigned 2 vCPU, 6 GB static memory, and a 100 GB dynamically expanding VHDX.
- Disabled Hyper-V Dynamic Memory after verification showed the guest was not receiving the approved static allocation.
- Removed the automatic checkpoint, merged the AVHDX into the main VHDX, and disabled future automatic checkpoints.
- Installed Ubuntu Server 22.04.5 LTS with kernel 5.15.0-186-generic.
- Configured static network settings:
  - IP: <SPLUNK-IP>/24
  - Gateway: <OPNSENSE-LAN-IP>
  - DNS: <DC01-IP>
  - Search domain: violetops.internal
  - Interface: eth0
  - MAC: <SPLUNK-MAC>
- Verified external IPv4 connectivity and DNS resolution.
- Installed Splunk Enterprise 10.4.1 under `/opt/splunk`.
- Created and used the dedicated `splunk` service account.
- Enabled Splunk boot-start under the `splunk` service account.
- Verified Splunk started successfully after reboot.
- Verified Splunk Web access at `http://<SPLUNK-IP>:8000`.
- Verified Splunk management API listening on TCP 8089.
- Configured continuous monitoring of `/var/log/syslog`.
- Configured:
  - Host: violetops-splunk
  - Sourcetype: linux_messages_syslog
  - Effective index: main
- Added the `splunk` account to the `adm` group so it could read `/var/log/syslog`.
- Verified the effective input configuration in `/opt/splunk/etc/apps/search/local/inputs.conf`.
- Verified more than 6,700 syslog events were indexed and current ingestion continued after reboot.
- Verified Ubuntu root filesystem had approximately 79 GB available.
- Verified Ubuntu UFW status was inactive.
- Verified the Ubuntu package baseline was fully up to date.
- Recorded that the Splunk email-alert security warning was not applicable because email alert actions are not configured.
- No OPNsense firewall, NAT, DHCP, VLAN, routing, physical-switch, or virtual-switch changes were required.
- GitHub documentation remains unchanged pending sanitization review.
