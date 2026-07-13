# VioletOps Build Log

## July 3, 2026 — Hyper-V Internal LAN Switch

### Configuration

- Created Hyper-V internal switch: `VioletOps-LAN`
- Created host virtual adapter: `vEthernet (VioletOps-LAN)`
- Assigned host management address: `10.10.10.2/24`
- VioletOps LAN network: `10.10.10.0/24`
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

## July 3, 2026 — OPNsense LAN Attachment

### Configuration

- Connected `OPNsense-Gateway` adapter `LAN` to `VioletOps-LAN`
- OPNsense LAN MAC address: `00155D0AF012`
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

## July 3, 2026 — Hyper-V External WAN Switch

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

## July 3, 2026 — OPNsense WAN Attachment

### Configuration

- Connected `OPNsense-Gateway` adapter `WAN` to `VioletOps-WAN`
- OPNsense WAN MAC address: `00155D0AF011`
- Final adapter mapping:
  - `WAN` → `VioletOps-WAN`
  - `LAN` → `VioletOps-LAN`
- OPNsense power state during change: Off

### Verification

- Verified both adapter-to-switch assignments
- Verified OPNsense remained powered off
- Verified Windows host management remains on Wi-Fi
- No host-side WAN virtual adapter exists

### Documentation

- Updated `OPNsense-Gateway.md`
- Updated `HyperV_Virtual_Switch_Design.md`

## July 3, 2026 — Hyper-V Storage Path Review

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

## July 3, 2026 — Pre-Resumption Follow-Up Complete

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

## July 3, 2026 — OPNsense Memory Increase

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

## July 11, 2026 — Phase 2.5 Host 2 Baseline

### Configuration

- Enabled Microsoft Hyper-V on Host 2.
- Set Windows Time service to Automatic and started the service.
- Configured time source: `time.windows.com,0x8`.
- Created local Host 2 baseline file:
  - `C:\VioletOps\Documentation\Host2_HyperV_Baseline.md`

### Verification

- Host 2 device name: `DESKTOP-OD4CHNC`
- Hyper-V feature: Enabled
- `vmms`: Running / Automatic
- `vmcompute`: Running / Manual
- Existing virtual machines: 0
- Existing virtual switches:
  - `Default Switch` — Internal
- Physical disk: SK hynix PC801 HFS001TEJ9X101N
- Disk capacity: 1 TB
- Partition style: GPT
- Disk health: Healthy
- BitLocker: Off / Fully decrypted
- Windows Time synchronization: Verified
- NTP leap indicator: 0 — no warning
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

## July 11, 2026 — VM Inventory Created

### Configuration

- Created `C:\VioletOps\Documentation\VM Inventory\VioletOps_VM_Inventory.md`.

### Verification

- Documented `OPNsense-Gateway` on Host 1.
- Documented Host 2 as Hyper-V enabled with zero existing VMs.
- Documented that Host 2 has no custom virtual switches.
- Documented that no additional VM placement decisions have been made.

### Documentation

- Created `VioletOps_VM_Inventory.md`.

## July 11, 2026 — Dual-Host Baseline Architecture Created

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

## July 11, 2026 — IP Addressing and Firewall Baseline Documented

### Configuration

- Created `C:\VioletOps\Documentation\IP Addressing Plan\VioletOps_IP_Addressing_Plan.md`.
- Created `C:\VioletOps\Documentation\Firewall Rules\VioletOps_Firewall_Rules.md`.

### Verification

- Documented Host 1 management address: `10.0.0.130`.
- Documented Host 2 temporary management address: `10.0.0.110`.
- Documented OPNsense LAN address: `10.10.10.1/24`.
- Documented Host 1 VioletOps LAN address: `10.10.10.2/24`.
- Documented DHCP range: `10.10.10.100–10.10.10.199`.
- Verified no new static IP, VLAN, NAT, or firewall-rule changes were made during Phase 2.5.
- Verified OPNsense WAN remains disconnected.

### Documentation

- Created `VioletOps_IP_Addressing_Plan.md`.
- Created `VioletOps_Firewall_Rules.md`.

## July 11, 2026 — Dual-Monitor and Peripheral Baseline

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

## July 11, 2026 — Monitor Models Verified

### Verification

- Monitor 1 verified as Dell P2419H.
- Monitor 1 serial number: `[REDACTED]`.
- Monitor 2 verified as Dell P2419H.
- Monitor 2 serial number: `[REDACTED]`.

### Documentation

- Updated `Hardware.md`.

## July 11, 2026 — Dual-Host Display Architecture Updated

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

## July 11, 2026 — Dual-Host Capacity Verified

### Verification

- Host 1 `DESKTOP-BG2AKA3`:
  - RAM: 31.79 GB
  - C: 780.50 GB total / 698.53 GB free
  - V: 150.00 GB total / 138.18 GB free
- Host 2 `DESKTOP-OD4CHNC`:
  - RAM: 31.78 GB
  - C: 952.93 GB total / 889.97 GB free
- Verified Host 2 currently has more available VM storage.
- No VM workload assignments were made.

### Documentation

- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 12, 2026 — Host 2 Hyper-V Storage Paths Updated

### Configuration Change

- Host: `DESKTOP-OD4CHNC`
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

## July 12, 2026 — Host 2 Network Adapter Baseline Verified

### Host

- Computer: `DESKTOP-OD4CHNC`

### Verified Adapters

- Intel Ethernet:
  - Adapter name: `Ethernet`
  - Interface: Intel(R) Ethernet Connection (7) I219-LM
  - Status: Up
  - Link speed: 1 Gbps
  - MAC address: `E4-54-E8-96-76-5C`
  - Current role: Host management
  - Current IPv4 address: `10.0.0.110`
- USB Wi-Fi:
  - Adapter name: `Wi-Fi 2`
  - Interface: Realtek RTL8811AU Wireless LAN 802.11ac USB 2.0 Network Adapter
  - Status: Disconnected
  - MAC address: `E8-4E-06-7C-EA-2E`
  - Current role: Unassigned
- Hyper-V virtual adapter:
  - Adapter name: `vEthernet (Default Switch)`
  - Status: Up
  - MAC address: `00-15-5D-20-74-F3`

### Change Control

- No custom Host 2 Hyper-V switch was created.
- No IP address, VLAN, firewall rule, NAT rule, or route was changed.
- Updated `VioletOps_Dual_Host_Baseline.md`.

## July 12, 2026 — Managed Switch Physical Baseline Verified

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

## July 12, 2026 — Managed Switch Identified

### Asset Details

- Model: TP-Link TL-SG108E
- Label text: `UN/6.6`
- Hardware version: Unverified
- MAC address: `50-3D-D1-E2-28-7C`
- Serial number: `Y258220001247`

### Status

- Power state: Unplugged
- Deployment status: Not deployed
- No switch configuration or cabling change was made.
- Updated `Hardware.md`.

## July 12, 2026 — Managed Switch Power-On Test

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

## July 12, 2026 — Host 2 Wi-Fi Management Path Verified

### Configuration

- Host 2 Wi-Fi profile: `WiFi`
- Interface: `Wi-Fi 2`
- IPv4 address: `10.0.0.226`
- Default gateway: `10.0.0.1`
- Network category: Private
- Host 1 Wi-Fi profile also changed to Private.

### Firewall Change

- Host 1 inbound ICMPv4 echo rule enabled.
- Rule scope restricted to Private profile only.
- Host 2 successfully pinged Host 1 at `10.0.0.130`.

### Addressing Decision

- Host 2 Ethernet address `10.0.0.110` is no longer the active management path.
- Host 2 Wi-Fi is now the management connection.
- Updated `VioletOps_IP_Addressing_Plan.md`.
- Updated `VioletOps_Firewall_Rules.md`.

## July 12, 2026 — Mouse Without Borders Restored

### Configuration

- Host 1 Wi-Fi profile: Private
- Host 2 Wi-Fi profile: Private
- Host 1 Mouse Without Borders inbound rule:
  - Program: `C:\Users\Admin\AppData\Local\PowerToys\PowerToys.MouseWithoutBorders.exe`
  - Profile: Private
- Host 2 Mouse Without Borders inbound rule:
  - Program: `C:\Users\pp\AppData\Local\PowerToys.MouseWithoutBorders.exe`
  - Profile: Private
- Host 2 Mouse Without Borders helper inbound rule:
  - Program: `C:\Users\pp\AppData\Local\PowerToys\PowerToys.MouseWithoutBordersHelper.exe`
  - Profile: Private

### Verification

- Host 2 reached Host 1 at `10.0.0.130`.
- Mouse movement between monitors works.
- Cross-PC clipboard copy and paste works.
- PowerToys `Refresh connections` restored the active session.
- No Public-profile firewall access was allowed.

### Documentation

- Updated `VioletOps_Firewall_Rules.md`.

## July 12, 2026 — Host 2 Ethernet Released for Lab Use

### Verification

- Host: `DESKTOP-OD4CHNC`
- Interface: `Ethernet`
- Adapter: Intel(R) Ethernet Connection (7) I219-LM
- Status: Disconnected
- Active management path: `Wi-Fi 2`
- Management IPv4 address: `10.0.0.226`

### Design Decision

- Host 2 Ethernet is reserved for future VioletOps lab networking.
- No switch cable, VLAN, IP address, route, NAT rule, or firewall rule was added during this step.

## July 12, 2026 — Managed Switch Port 2 Connected to Host 2

### Physical Connection

- Switch: TP-Link TL-SG108E
- Port: 2
- Connected device: Host 2 `DESKTOP-OD4CHNC`
- Host interface: Intel(R) Ethernet Connection (7) I219-LM
- Port 2 LED: On
- Physical link: Up

### Network State

- Ethernet profile: Unidentified network
- Automatic IPv4 address: `169.254.125.231`
- Default gateway: None
- DHCP server: None detected
- Host 2 management remains on Wi-Fi `10.0.0.226`

### Change Control

- No static IP address was assigned.
- No VLAN, firewall rule, route, NAT rule, or additional switch port was configured.
- Updated `VioletOps_Dual_Host_Baseline.md`.


## July 12, 2026 — Phase 2.5 Closure

### Status

- Phase 2.5 — Dual-Host Hardware and Monitor Baseline: Complete
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

- Resume Phase 2 — OPNsense Firewall Configuration and Validation

