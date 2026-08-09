# VioletOps Hardware Inventory



Status: Complete

Last Updated: August 8, 2026



## Host 1 — Original VioletOps Hyper-V Host



- Role: Primary VioletOps Hyper-V host

- Model: Dell OptiPlex 7070 Micro

- CPU: Intel Core i7-9700

- RAM: 32 GB

- Storage: 1 TB NVMe SSD

- Operating system: Windows 11 Pro

- Hyper-V: Enabled

- Management internet: Wi-Fi

- Wi-Fi IPv4 address: <HOST-1-MANAGEMENT-IP>

- VioletOps LAN host address: <HOST-1-LAB-IP>/24

- Notes:

  - Hosts the current OPNsense-Gateway VM.

  - Physical Ethernet adapter is reserved for VioletOps-WAN.

  - OPNsense WAN cable remains disconnected.



## Host 2 — New VioletOps Computer



- Role: Core server and monitoring host

- Model: Dell OptiPlex 7070

- Device name: <HOST-2-NAME>

- CPU: Intel Core i7-9700 @ 3.00 GHz

- RAM: 32 GB

- Storage: 1 TB SK hynix PC801 NVMe SSD

- Graphics: Intel UHD Graphics 630

- Operating system: Windows 11 Pro

- Windows version: 25H2

- OS build: 26200.7623

- Install date: 6/10/2026

- Current internet connection: Wi-Fi 2

- Previous Ethernet management IPv4 address: <HOST-2-PREVIOUS-MANAGEMENT-IP>

- Ethernet MAC address: <ETHERNET-MAC>

- Ethernet link speed: 1 Gbps

- Wi-Fi adapter name: Wi-Fi 2

- Wi-Fi MAC address: <WIFI-MAC>

- Wi-Fi status: Disconnected

- BIOS virtualization: Intel Virtualization Technology checked/enabled

- VT for Direct I/O: Present in BIOS menu

- Hyper-V status: Enabled and verified
- Hyper-V core services: vmms Running/Automatic; vmcompute Running/Manual
- Existing virtual machines: 0
- Custom virtual switches: 0; built-in Default Switch only
- Disk health: Healthy / Operational status OK
- Disk partition style: GPT
- BitLocker: Off; volume fully decrypted
- Windows Time service: Running / Automatic
- Time source: time.windows.com,0x8; synchronization verified

- Notes:

  - USB Wi-Fi adapter driver is installed and verified.

  - Host 2 is verified as virtualization-ready.
  - Final VM workload role and dedicated Hyper-V datastore design have not been assigned yet.



## Network Hardware



- Managed switch: TP-Link TL-SG108E

- Current use: Available for VioletOps lab networking

- Router connection: Host 2 is connected to the home router by Wi-Fi at <HOST-2-MANAGEMENT-IP>



## Displays and Peripherals

- Dual monitors: Installed and in use
- Verified monitor models:
  - Monitor 1: Dell P2419H, serial `[REDACTED]`
  - Monitor 2: Dell P2419H, serial `[REDACTED]`
- Monitor 1:
  - Position: Left
  - Connected host: Host 1 / Micro PC
  - Current connection: DisplayPort to DisplayPort
  - Available video inputs:
    - 1 HDMI
    - 1 DVI
  - USB ports:
    - 2 standard USB downstream ports
    - 1 blue SuperSpeed USB-B upstream port
- Monitor 2:
  - Position: Right
  - Connected host: Host 2 / Tower PC
  - Current connection: DisplayPort to DisplayPort
  - Available video inputs:
    - 1 HDMI
    - 1 DVI
  - USB ports:
    - 2 standard USB downstream ports
    - 1 blue SuperSpeed USB-B upstream port
- Host 1 video ports:
  - DisplayPort ports: 2 total
  - DisplayPort ports available: 1
- Host 2 video ports:
  - DisplayPort ports: 2 total
  - DisplayPort ports available: 1
- Spare video cables:
  - 2 DisplayPort-to-HDMI cables
- Current keyboard/mouse sharing:
  - Microsoft PowerToys Mouse Without Borders
  - Cross-PC copy and paste works
  - One-keyboard/one-mouse operation is not yet seamless
- Future keyboard/mouse option:
  - Monitor USB hubs may support a cleaner shared-device design
  - USB upstream cables and switching method not yet selected
- KVM switch:
  - Not installed
  - Deferred as a later improvement
## Change Record



### July 11, 2026 — Hardware Inventory Created



- Created initial VioletOps hardware inventory.

- Added Host 1 baseline.

- Added Host 2 baseline from Windows About, PowerShell network adapter output, IP configuration, and BIOS virtualization screen.

- Dual monitors and USB Wi-Fi are verified; final Host 2 workload placement is approved.

### July 11, 2026 — Host 2 Hyper-V and Storage Baseline Verified

- Enabled Microsoft Hyper-V on Host 2.
- Verified vmms and vmcompute services are running.
- Verified zero existing VMs and only the built-in Default Switch.
- Verified the 1 TB NVMe SSD is healthy, GPT-partitioned, and fully decrypted.
- Verified Windows Time synchronization with time.windows.com.
- No custom virtual networking, VM placement, or datastore changes were made.






## Managed Switch

- Model: TP-Link TL-SG108E
- Label text: `UN/6.6`
- Hardware version: Unverified
- MAC address: <MANAGED-SWITCH-MAC>
- Serial number: <MANAGED-SWITCH-SERIAL>
- Current power state: Powered on
- Current deployment status: Connected and operational in the VioletOps dual-host topology
- Verified physical port assignments:
  - Port 1: Upstream gateway
  - Port 2: Host 2 built-in Ethernet
  - Port 3: Host 1 built-in Ethernet
  - Port 4: Host 1 USB Ethernet
- VLAN 10 provides the isolated OPNsense WAN path through Ports 1 and 3.
