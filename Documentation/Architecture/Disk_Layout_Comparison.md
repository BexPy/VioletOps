# VioletOps Disk Layout Comparison

Status: Complete
Started: July 3, 2026
Last verified: August 15, 2026

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
- Current `C:` size: 780.5 GB
- Current `C:` free space: 563.4 GB as of August 15, 2026
- Current `V:` size: 150 GB
- Current `V:` free space: 132.18 GB as of August 15, 2026
- Current `V:` label: `HyperV-VMs`
- Current `V:` file system: NTFS
- Current `V:` allocation unit size: 4 KB
- Current `V:` purpose: Stores the `OPNsense-Gateway` virtual disk

## Key Differences

- `C:` is approximately 430 GB larger than originally planned.
- `V:` is approximately 450 GB smaller than originally planned.
- The current `V:` label differs from the original planned label.
- The current `V:` allocation unit size is 4 KB instead of the planned 64 KB.
- The current `V:` capacity was not adopted as the sole datastore for the VioletOps VM environment.

## Hyper-V Storage Path Review

- Current default VM path: `C:\HyperV\Virtual Machines`
- Current default VHD path: `C:\HyperV\Virtual Hard Disks`
- Current OPNsense virtual disk path: `V:\HyperV-VMs\OPNsense-Gateway\OPNsense-OS.vhdx`
- `V:` is not used as the global Hyper-V default datastore.
- Current verified use of `V:` is limited to the `OPNsense-Gateway` virtual disk.
- No storage-layout change is required for the completed VioletOps environment.

## Change Record

### July 3, 2026

- Documented the difference between the original planned layout and the verified layout at that time.
- Reviewed the Hyper-V default storage paths.
- Recorded the decision not to use `V:` as the global Hyper-V datastore.
- No disk partitions or Hyper-V storage paths were changed during that review.

### August 15, 2026

- Revalidated `C:` and `V:` capacity and free space.
- Confirmed `V:` remains NTFS with a 4 KB allocation unit size.
- Confirmed `OPNsense-Gateway` remains the only VM virtual disk currently stored on `V:`.
- Updated the documented Hyper-V default paths to the currently verified `C:\HyperV` locations.
- Removed stale language referring to VioletOps VMs as future deployments.
- No disk partition, VM storage location, or Hyper-V storage configuration was changed during this documentation review.
