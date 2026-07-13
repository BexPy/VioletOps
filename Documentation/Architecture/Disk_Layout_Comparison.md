# VioletOps Disk Layout Comparison

Status: Complete  
Started: July 3, 2026

## Original Planned Layout

- Physical disk: Samsung 970 EVO Plus 1TB
- Partition style: GPT
- Planned `C:` size: Approximately 350 GB
- Planned `V:` size: Approximately 600+ GB
- Planned `V:` label: `HyperV-Datastore`
- Planned `V:` file system: NTFS
- Planned `V:` allocation unit size: 64 KB
- Planned purpose: Primary Hyper-V VM and virtual disk datastore

## Current Verified Layout

- Physical disk: Samsung 970 EVO Plus 1TB
- Partition style: GPT
- Current `C:` size: Approximately 780 GB
- Current `C:` free space: Approximately 707 GB
- Current `V:` size: Approximately 150 GB
- Current `V:` free space: Approximately 143 GB
- Current `V:` label: `HyperV-VMs`
- Current `V:` file system: NTFS
- Current `V:` allocation unit size: 4 KB
- Current `V:` purpose: Stores the existing `OPNsense-Gateway` VM

## Key Differences

- `C:` is approximately 430 GB larger than originally planned.
- `V:` is approximately 450 GB smaller than originally planned.
- The current `V:` label differs from the original planned label.
- The current `V:` allocation unit size is 4 KB instead of the planned 64 KB.
- The current `V:` capacity is not suitable as the sole datastore for all planned VioletOps VMs.

## Hyper-V Storage Path Review

- Current default VM path: `C:\ProgramData\Microsoft\Windows\Hyper-V`
- Current default VHD path: `C:\ProgramData\Microsoft\Windows\Virtual Hard Disks`
- Existing OPNsense storage path: `V:\HyperV-VMs\OPNsense-Gateway`
- Recommended current decision: Do not move the global Hyper-V defaults to `V:` yet.
- Reason: `V:` has only approximately 143 GB free, while future Windows, Kali, Wazuh, and Splunk VMs may exceed that capacity.
- Interim approach: Continue selecting VM storage locations individually until the disk layout is redesigned or expanded.

## Change Record

### July 3, 2026

- Documented the difference between the original planned layout and the current verified layout.
- Reviewed the current Hyper-V default storage paths.
- Recorded the decision to leave global Hyper-V defaults on `C:` for now.
- No disk partitions or Hyper-V storage paths were changed.
