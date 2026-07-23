# **Windows Pre-Resumption Health Check**

Status: Complete  
Started: July 3, 2026- Completed: July 3, 2026

This checklist verifies that the Windows 11 Pro host is healthy before VioletOps configuration resumes.

Before we create a single VM...

I'd like us to verify that Windows itself is completely healthy.

We'll check:

* BIOS virtualization settings  
* Hyper-V  
* Windows Features  
* Virtual Switch Manager  
* Network adapters  
* Disk layout  
* Memory allocation  
* Virtualization extensions  
* Existing Hyper-V virtual switches  
* Old VMware adapters (if any remain)

That takes maybe 20â€“30 minutes, and once it's done we'll have a clean foundation.

\#\# Verified Results

\- BIOS virtualization: Enabled

\- Hypervisor present: True

\- Hyper-V platform and management features: Enabled

\- Hyper-V services: Running

\- Existing Hyper-V switch: Default Switch only

\- Physical Ethernet adapter: Intel I219-LM, disconnected

\- Wi-Fi adapter: Intel Wireless-AC 9560, connected

\- VMware adapters, services, packages, and drivers: None found

\- Physical disk: Samsung SSD 970 EVO Plus 1TB, GPT, Healthy

\- C: volume: NTFS, approximately 780 GB

\- V: volume: NTFS, approximately 150 GB

\- V: volume label: HyperV-VMs

\- V: allocation unit size: 4096 bytes

\- Installed RAM detected by Windows: 31.79 GB

\- OPNsense VM: Powered off, 2 vCPU, 2 GB static RAM

\- OPNsense VHDX location: V:\\HyperV-VMs\\OPNsense-Gateway\\OPNsense-OS.vhdx

\- OPNsense WAN and LAN adapters: Present but not attached to a virtual switch

\- OPNsense automatic checkpoints: Disabled

\- Hyper-V default VM and VHD paths: Still configured on C:

\#\# Items Requiring Later Configuration

\- Rebuild and document the VioletOps Hyper-V virtual switches

\- Reconnect OPNsense WAN and LAN adapters after network design verification

\- Review whether Hyper-V default storage paths should be changed to V:

\- Document the difference between the current disk layout and the original planned layout
